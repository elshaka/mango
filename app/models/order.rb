include MangoModule

class Order < ActiveRecord::Base
  attr_protected :id

  belongs_to :recipe
  belongs_to :medicament_recipe
  belongs_to :parameter_list
  belongs_to :client
  belongs_to :user
  belongs_to :product_lot
  has_many :batch
  has_many :alarms
  has_many :transactions
  has_many :order_stats
  has_many :areas

  #attr_protected :completed

  validates :product_lot, presence: {unless: :auto_product_lot}
  validates :recipe, :user, :client, presence: true
  validates :prog_batches,
            numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :real_batches, numericality: {allow_nil: true}
  validates :real_production,
            numericality: {greater_than: 0, allow_nil: true}
  validate :product_lot_factory
  validate :product_lot_recipe

  before_create :create_code
  before_create :set_notified
  before_save :update_real_consumptions, if: :real_production_changed?

  STATES = {
    0 => {name: 'Sin completar', condition: 'completed = false'},
    1 => {name: 'Sin notificar', condition: 'completed = TRUE AND notified = FALSE'},
    2 => {name: 'Notificadas', condition: 'completed = TRUE AND notified = TRUE'},
  }

  def product_lot_factory
    if self.client_id and self.product_lot_id and not self.auto_product_lot
      if self.client.factory and not self.product_lot.client_id == self.client_id
        errors.add(:product_lot, "no pertenece a la fabrica")
      end
    end
  end

  def product_lot_recipe
    if self.product_lot_id and self.recipe_id and not self.auto_product_lot
      if self.product_lot.product_id != self.recipe.product_id
        errors.add(:product_lot, "no corresponde a la receta")
      end
    end
  end

  def create_code
    order_number = OrderNumber.first
    self.code = order_number.code.succ
    order_number.code = self.code
    order_number.save
    self.product_lot_id = nil if self.auto_product_lot
  end

  def set_notified
    self.notified = !is_mango_feature_available("notifications")
    true
  end

  def update_real_consumptions
    bhls = BatchHopperLot
      .joins(:batch)
      .where(batches: {order_id: self.id})
    if bhls.count > 0
      theoric_total = bhls.sum(:amount)
      ratio = (self.real_production / theoric_total)
      bhls.update_all("real_amount = round(amount * #{ratio}, 2)")
    end
  end

  def validate
    hopper_ingredients_ids = HopperLot
      .includes(:lot, :hopper)
      .where(hoppers_lots: {active: true}, hoppers: {main: true})
      .pluck("lots.ingredient_id")

    recipe_ingredients = IngredientRecipe
      .where(recipe_id: self.recipe_id)
      .pluck(:ingredient_id, :amount)
      .inject({}) do |hash, ir|
        hash[ir[0]] = ir[1]
        hash
      end
    recipe_ingredients.merge!(IngredientMedicamentRecipe
      .where(medicament_recipe_id: self.medicament_recipe_id)
      .pluck(:ingredient_id, :amount)
      .inject(recipe_ingredients) do |hash, ir|
        unless recipe_ingredients.has_key? ir[0]
          hash[ir[0]] = ir[1]
        end
        hash
      end ) if self.medicament_recipe_id

    unavailable_ingredients_ids = recipe_ingredients.keys - hopper_ingredients_ids

    valid = unavailable_ingredients_ids.empty?

    missing_ingredients_names = Ingredient.where(id: unavailable_ingredients_ids)
      .pluck(:name)

    scale_amounts = []
    if valid
      scale_amounts = Scale.where(not_weighed: false).map do |scale|
        hopper_amounts = HopperLot
          .includes(:lot, :hopper)
          .where(hoppers_lots: {active: true}, hoppers: {main: true, scale_id: scale.id}, lots: {ingredient_id: recipe_ingredients.keys})
          .pluck('hoppers.number', 'lots.ingredient_id')
          .map { |hopper| {number: hopper[0], amount: recipe_ingredients[hopper[1]]} }
        {scale_id: scale.id, hoppers: hopper_amounts}
      end
    end

    parameters = []
    parameters = self.parameter_list.parameters.map { |parameter|
      {type: parameter.parameter_type_id, value: parameter.value}
    } if self.parameter_list

    {
      valid: valid,
      missing_ingredient_names: missing_ingredients_names,
      scale_amounts: scale_amounts,
      parameters: parameters
    }
  end

  def repair(user_id, params)
    n_batch = Integer(params[:n_batch]) rescue 0
    hopper_ingredients = HopperLot
      .joins(:lot, :hopper)
      .where(hoppers_lots: {active: true}, hoppers: {main: true})
      .pluck("hoppers_lots.id", "lots.ingredient_id")
      .inject({}) do |hash, hl|
        hash[hl[1]] = hl[0]
        hash
      end

    recipe_ingredients = IngredientRecipe
      .where(recipe_id: self.recipe_id)
      .pluck(:ingredient_id, :amount)
      .inject({}) do |hash, ir|
        hash[ir[0]] = ir[1]
        hash
      end
    recipe_ingredients.merge!(IngredientMedicamentRecipe
      .where(medicament_recipe_id: self.medicament_recipe_id)
      .pluck(:ingredient_id, :amount)
      .inject(recipe_ingredients) do |hash, ir|
        unless recipe_ingredients.has_key? ir[0]
          hash[ir[0]] = ir[1]
        end
        hash
      end ) unless self.medicament_recipe.nil?

    unavailable_ingredients_ids = recipe_ingredients.keys - hopper_ingredients.keys

    unavailable_ingredients_ids.each do |ingredient_id|
      last_hopperlot = HopperLot
        .joins(:lot)
        .where(lots: {ingredient_id: ingredient_id})
        .last
      return false if last_hopperlot.nil?
      hopper_ingredients[ingredient_id] = last_hopperlot.id
    end

    if self.client.factory
      hopper_ingredients.each do |ingredient_id, hopper_lot_id|
        hfl = HopperFactoryLot.where(hopper_lot_id: hopper_lot_id, client_id: self.client_id).first
        if hfl.present? and hfl.lot_id.present?
          hopper_lot = hfl.hopper_lot.hopper.hopper_lot.new
          hopper_lot.lot_id = hfl.lot_id
          hopper_lot.active = false
          hopper_lot.factory = true
          hopper_lot.save(validate: false)
          hopper_ingredients[ingredient_id] = hopper_lot.id
        end
      end
    end

    transaction do
      BatchHopperLot.skip_callback(
        :create,
        :after,
        :update_batch_end_date
      )
      now = Time.now
      real_batch = self.batch.count
      if real_batch < n_batch
        schedule_id = Schedule.get_current_schedule_id(now)
        (n_batch - real_batch).times do |n|
          batch = self.batch
            .new(user_id: user_id,
                 number: real_batch + n + 1,
                 schedule_id: schedule_id,
                 start_date: now,
                 end_date: now)
          batch.save(validate: false)
          recipe_ingredients.each do |key, value|
            batch.batch_hopper_lot
              .new(hopper_lot_id: hopper_ingredients[key],
                                  standard_amount: value,
                                  amount: value)
              .save(validate: false)
          end
        end
      end

      batches_ingredients = self.batch
        .joins(batch_hopper_lot: {hopper_lot: {lot: {}}})
        .pluck("batches.id", "lots.ingredient_id")
        .inject(Hash.new {|hash, key| hash[key] = []}) do |hash, bi|
          hash[bi[0]] << bi[1]
          hash
        end

      batches_ingredients.each do |batch_id, ingredients_ids|
        missing_ingredients = recipe_ingredients.keys - ingredients_ids
        missing_ingredients.each do |ingredient_id|
          BatchHopperLot
            .new(batch_id: batch_id,
                 hopper_lot_id: hopper_ingredients[ingredient_id],
                 standard_amount: recipe_ingredients[ingredient_id],
                 amount: recipe_ingredients[ingredient_id])
            .save(validate: false)
        end
      end
      BatchHopperLot.set_callback(:create,
                                  :after,
                                  :update_batch_end_date)

      extra_batches_ids = self.batch
        .where(['number > ?', n_batch])
        .pluck(:id)
      unless extra_batches_ids.empty?
        BatchHopperLot.where(batch_id: extra_batches_ids).delete_all
        Batch.where(id: extra_batches_ids).delete_all
      end

      self.create_product_lot if self.auto_product_lot

      Order.where(id: self.id)
        .update_all({prog_batches: n_batch,
                     real_batches: n_batch,
                     completed: true,
                     repaired: true,
                     updated_at: now})
    end

    transaction do
      params[:ingredients].each do |ingredient|
        if ingredient[:modify] == "1"
          total = ingredient[:real].to_f
          next if total < 0

          amount = (total / n_batch).round(2)
          diff = total - amount * n_batch
          bhls = BatchHopperLot
            .joins({batch: {}, hopper_lot: {lot: {}}})
            .where({batches: {order_id: self.id}})
            .where({lots: {ingredient_id: ingredient[:id]}})
          bhls.update_all(amount: amount)
          unless bhls.last.nil?
            bhls.last.update_column(:amount, amount + diff)
          end
        end
      end
    end
    if is_mango_feature_available("transactions") && !is_mango_feature_available("notifications")
      self.generate_transactions(user_id)
    end
    true
  end

  def generate_transactions(user_id)
    loss_enabled = is_mango_feature_available("ingredient_loss")
    consumptions = {}
    order_transactions = self.transactions
    batches = Batch
      .includes({batch_hopper_lot: {hopper_lot: {}}})
      .where(order_id: self.id)
    production = 0
    batches.each do |b|
      b.batch_hopper_lot.each do |bhl|
        key = bhl.hopper_lot.lot_id
        amount = bhl.amount
        production += amount
        if loss_enabled
          amount *= (1 + bhl.hopper_lot.lot.ingredient.loss / 100)
        end
        if consumptions.has_key? key
          consumptions[key] += amount
        else
          consumptions[key] = amount
        end
      end
    end
    consumptions.each do |key, amount|
      previous_amount = order_transactions.inject(0) do |sum, t|
        (t.content_type == 1 and t.content_id == key) ? sum + t.amount : sum
      end
      amount -= previous_amount unless previous_amount == 0
      self.transactions.create(
        {amount: amount,
         transaction_type_id: 1,
         content_type: 1,
         content_id: key,
         processed_in_stock: 1,
         user_id: user_id}) unless amount < 0.01
    end

    previous_amount = order_transactions.inject(0) do |sum, t|
      (t.content_type == 2) ? sum + t.amount : sum
    end
    production -= previous_amount unless previous_amount == 0
    self.transactions.create(
      {amount: production,
       transaction_type_id: 6,
       content_type: 2,
       content_id: self.product_lot_id,
       processed_in_stock: 1,
       user_id: user_id}) unless production < 0.01
  end

  def close(user_id)
    unless self.completed
      self.create_product_lot if self.auto_product_lot
      self.generate_transactions(user_id) if is_mango_feature_available("transactions") && !is_mango_feature_available("notifications")
      self.update_column(:completed, true)
    else
      false
    end
  end

  def create_product_lot
    product = self.recipe.product
    date_string = Date.today.strftime('%d%m%y')
    last_product_lot_code = ProductLot
      .where("code LIKE ? AND product_id = ?",
             "%#{product.code}-#{date_string}%",
             product.id)
      .pluck(:code).last
    product_lot_code = "#{product.code}-#{date_string}-"
    product_lot_code += last_product_lot_code.nil? ? "1" :
                        last_product_lot_code.split("-").last.succ
    self.update_column(:product_lot_id,
      ProductLot.create(
        code: product_lot_code,
        product_id: product.id,
        client_id: self.client.factory ? self.client_id : nil
      )).id
  end

  def get_standard_amount(ingredient_id)
    if self.medicament_recipe_id.nil?
      IngredientRecipe
        .where({recipe_id: self.recipe_id,
                ingredient_id: ingredient_id})
        .pluck(:amount).first ||
      0
    else
      IngredientRecipe
        .where({recipe_id: self.recipe_id,
                ingredient_id: ingredient_id})
        .pluck(:amount).first ||
      IngredientMedicamentRecipe
        .where({medicament_recipe_id: self.medicament_recipe_id,
                ingredient_id: ingredient_id})
        .pluck(:amount).first ||
      0
    end
  end

  def deep_destroy
    transaction do
      batch_ids = Batch.where(order_id: self.id).pluck(:id)
      BatchHopperLot.where(batch_id: batch_ids).delete_all
      Batch.where(id: batch_ids).delete_all
      Alarm.where(order_id: self.id).delete_all
      self.delete
    end
  end

  def self.generate_consumption(params, user_id)
    errors = []
    # Add some shitty error handling
    if errors.empty?
      now = Time.now
      order = Order.where(code: params[:order_code]).first
      batch = order.batch
        .find_or_create_by_number number: params[:batch_number],
                                  schedule_id: Schedule.get_current_schedule_id(now),
                                  user_id: user_id,
                                  start_date: now,
                                  end_date: now
      hopper = Hopper.where({scale_id: params[:scale_id],
                             number: params[:hopper_number]}).first
      hopper_lot = hopper.current_hopper_lot
      original_hopper_lot = hopper_lot # Horrible

      if order.client.factory
        hfl = HopperFactoryLot.where(hopper_lot_id: hopper_lot.id, client_id: order.client_id).first
        if hfl.present? and hfl.lot_id.present?
          hopper_lot = hopper.hopper_lot.new
          hopper_lot.lot_id = hfl.lot_id
          hopper_lot.active = false
          hopper_lot.factory = true
          hopper_lot.save(validate: false)
        end
      end

      batch_hopper_lot = batch.batch_hopper_lot.new
      batch_hopper_lot.hopper_lot_id = hopper_lot.id
      batch_hopper_lot.amount = params[:amount]
      batch_hopper_lot.standard_amount = order.get_standard_amount(hopper_lot.lot.ingredient_id)

      if batch_hopper_lot.save
        mango_features = get_mango_features()
        batch_hopper_lot.generate_transaction(user_id) if mango_features.include? "transactions"
        if mango_features.include? "hoppers_transactions"
          batch_hopper_lot.hopper_lot = original_hopper_lot
          batch_hopper_lot.generate_hopper_transaction(user_id)
        end
      end
    end
    errors
  end

  def self.generate_not_weighed_consumptions(params, user_id)
    errors = []
    now = Time.now
    order = Order.where(code: params[:order_code]).first

    amounts = IngredientRecipe
      .where(recipe_id: order.recipe_id)
      .pluck(:ingredient_id, :amount)
      .inject({}) do |hash, item|
        hash[item[0]] = item[1]
        hash
      end

    unless order.medicament_recipe_id.nil?
      amounts.merge!(IngredientMedicamentRecipe
        .where(medicament_recipe_id: order.medicament_recipe_id)
        .pluck(:ingredient_id, :amount)
        .inject({}) do |hash, item|
          hash[item[0]] = item[1]
          hash
        end )
    end

    hopper_amounts = HopperLot
      .joins({hopper: {scale: {}},
              lot: {ingredient: {}}})
      .where({active: true,
              hoppers: {main: true},
              scales: {not_weighed: true},
              ingredients: {id: amounts.keys}})
      .order('hoppers.number ASC')
      .pluck("hoppers_lots.id", "ingredient_id")
      .inject({}) do |hash, item|
        hash[item[0]] = amounts[item[1]]
        hash
      end

    if order.client.factory
      client_id = order.client_id
      transaction do
        hopper_amounts.dup.each do |hopper_lot_id, _|
          hfl = HopperFactoryLot.where(hopper_lot_id: hopper_lot_id, client_id: client_id).first
          if hfl.present? and hfl.lot_id.present?
            factory_hopper_lot = HopperLot.new
            factory_hopper_lot.hopper_id = hfl.hopper_lot.hopper_id
            factory_hopper_lot.lot_id = hfl.lot_id
            factory_hopper_lot.active = false
            factory_hopper_lot.factory = true
            factory_hopper_lot.save(validate: false)
            hopper_amounts[factory_hopper_lot.id] = hopper_amounts.delete(hopper_lot_id)
          end
        end
      end
    end

    batch = order.batch.find_or_create_by_number(
      number: params[:batch_number],
      schedule_id: Schedule.get_current_schedule_id(now),
      user_id: user_id,
      start_date: now,
      end_date: now
    )

    BatchHopperLot.skip_callback(:create, :after, :update_batch_end_date)
    transaction do
      hopper_amounts.each do |hopper_lot_id, amount|
        bhl = batch.batch_hopper_lot.new(
          hopper_lot_id: hopper_lot_id,
          amount: amount,
          standard_amount: amount
        )
        saved = bhl.save
        errors.append(hopper_lot_id) unless saved
        if saved and is_mango_feature_available("transactions")
          bhl.generate_transaction(user_id)
        end
      end
      batch.update_column(:end_date, now)
    end
    BatchHopperLot.set_callback(:create, :after, :update_batch_end_date)
    errors
  end

  def self.consumption_exists(params)
    BatchHopperLot
      .includes({batch: {order: {}},
                 hopper_lot: {hopper: {}}})
      .where({orders: {code: params[:order_code]},
              batches: {number: params[:batch_number]},
              hoppers: {scale_id: params[:scale_id],
                        number: params[:hopper_number]}})
      .any?
  end

  def self.create_order_stat(params)
    order_stat_type_id = params[:order_stat_type_id].to_i
    order_id = OrderArea.joins(area: {orders_stats_types: {}})
                        .where(active: true,
                               orders_stats_types: {id: order_stat_type_id})
                        .pluck(:order_id)
                        .first
    OrderStat.create(order_id: order_id,
                     order_stat_type_id: order_stat_type_id,
                     value: params[:value])
             .errors
             .messages
  end

  def self.update_order_area(params)
    errors = {}
    order_id = Order.where(code: params[:order_code]).pluck(:id).first
    area_id = Area.where(id: params[:area_id]).pluck(:id).first
    errors[:order_code] = "no existe" if order_id.nil?
    errors[:area_id] = "no existe" if area_id.nil?
    OrderArea.new(order_id: order_id, area_id: area_id)
             .save(validate: false) if errors.empty?
    errors
  end

  def self.search(params)
    orders = Order.includes(:recipe, :client, product_lot: {product: {}})
    orders = orders.where(code: params[:code]) if params[:code].present?
    orders = orders.where(recipes: {code: params[:recipe_code]}) if params[:recipe_code].present?
    orders = orders.where(client_id: params[:client_id]) if params[:client_id].present?
    orders = orders.where('orders.created_at >= ?', Date.parse(params[:start_date])) if params[:start_date].present?
    orders = orders.where('orders.created_at <= ?', Date.parse(params[:end_date]) + 1.day) if params[:end_date].present?
    orders = orders.where(STATES[params[:state_id].to_i][:condition]) if params[:state_id].present?
    orders = orders.order('orders.created_at DESC')
    orders.paginate page: params[:page], per_page: params[:per_page]
  end

  def self.get_open
    orders = Order.includes(:recipe, :client)
      .where(completed: false)
      .pluck('orders.code AS order_code', 'clients.name AS client_name', 'recipes.name AS recipe_name',
        'recipes.code AS recipe_code', 'orders.prog_batches')
      .map do |order|
        {code: order[0], client_name: order[1], recipe_name: order[2], recipe_code: order[3], prog_batches: order[4]}
      end
  end
end
