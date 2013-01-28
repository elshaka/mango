class Recipe < ActiveRecord::Base
  has_many :ingredient_recipe, :dependent => :destroy
  has_many :order
  belongs_to :mixing_time

  validates_presence_of :name, :code#, :mixing_time_id
  #validates_uniqueness_of :code
  validates_length_of :name, :within => 3..40
  #validates_associated :ingredient_recipe

  def is_associated?()
    Order.where(:recipe_id => self.id).any?
  end

  def add_ingredient(args)
    logger.debug("Agregando ingrediente: #{args.inspect}")
    overwrite = args[:overwrite]
    icode = args[:ingredient].split(' ')[0]
    iname = args[:ingredient][(icode.length + 1)..args[:ingredient].length].strip()
    ingredient = Ingredient.find_by_code(icode)
    if ingredient.nil?
      logger.debug("  - El ingrediente no existe. Se crea")
      ingredient = Ingredient.new :code => icode, :name => iname
      ingredient.save
    end
    item = IngredientRecipe.find :first, :conditions=>{:ingredient_id=>ingredient.id, :recipe_id=>self.id}
    if item.nil?
      item = IngredientRecipe.new
      item.ingredient_id = ingredient.id
      item.amount = args[:amount]
      item.priority = args[:priority]
      item.percentage = args[:percentage]
      self.ingredient_recipe << item
    else
      item.amount = args[:amount]
      item.priority = args[:priority]
      item.percentage = args[:percentage]
      item.save if overwrite
    end
    logger.debug("Ingrediente agregado: #{item.inspect}")
  end

  def validate
    hopper_ingredients = []
    hopper_lots = HopperLot.find :all, :conditions => ['active = true']
    hopper_lots.each do |hl|
      hopper_ingredients << hl.lot.ingredient.id
    end
    valid = true
    self.ingredient_recipe.each do |ir|
      unless hopper_ingredients.include? ir.ingredient.id
        valid = false
        break
      end
    end
    return valid
  end

  def import(filepath, overwrite)
    begin
      transaction do
        fd = File.open(filepath, 'r')
        continue = fd.gets().strip()
        return false unless validate_field(continue, 'Formula')

        while (continue)
          return false unless validate_field(fd.gets(), 'Code')
          fd.gets()
          return false unless validate_field(fd.gets(), 'Description')
          fd.gets()
          return false unless validate_field(fd.gets(), 'Date')
          return false unless validate_field(fd.gets(), 'Stored')
          fd.gets()
          return false unless validate_field(fd.gets(), 'Ver')
          header = fd.gets().split(/\t/)
          @recipe = Recipe.find_by_code(header[0])
          if @recipe.nil?
            @recipe = Recipe.new :code=>header[0], :name=>header[1], :version=>header[3].strip()
            logger.debug("Creando encabezado de receta #{@recipe.inspect}")
          end
          fd.gets()
          while (true)
            item = fd.gets().split(/\t/)
            break if item[0].strip() == '-----------'
            logger.debug("  * Ingrediente: #{item.inspect}")
            amount = convert_to_float(item[0])
            percentage = convert_to_float(item[3])
            @recipe.add_ingredient(
              :amount=>amount,
              :priority=>0,
              :percentage=>percentage,
              :ingredient=>item[2].strip(),
              :overwrite=>overwrite)
          end
          @recipe.total = convert_to_float(fd.gets().strip())
          @recipe.save
          continue = fd.gets().strip()
          break if continue.nil? or continue == '='
        end
      end
    rescue Exception => ex
      errors.add(:unknown, ex.message)
      return false
    end
    return true
  end

  def import_new(filepath, overwrite)
    begin
      transaction do
        file_total = 0
        file_imported = 0
        fd = File.open(filepath, 'r')
        continue = fd.gets().split(';')
        while (continue)
          file_total += 1
          header = continue
          return false unless validate_field(header[0], 'C')
          version = header[1]
          code = header[2]
          name = header[3].strip()
          total = header[5]

          @previously_stored_recipe = Recipe.find :first, :conditions => {:code => header[2], :version => header[1]}
          unless @previously_stored_recipe.nil?
            logger.debug("Receta: #{@previously_stored_recipe.code} version #{@previously_stored_recipe.version} ya existe")
            unless @previously_stored_recipe.active
              file_imported += 1
              @current_active_recipe = Recipe.find :first, :conditions => {:code => header[2], :active => true}
              @current_active_recipe.active = false
              @current_active_recipe.save
              @previously_stored_recipe.active = true
              @previously_stored_recipe.save
            end
            while (true)
              item = fd.gets()
              break if item.nil?
              item = item.split(';')
              break if item.length == 1
            end
          else
            @previous_version_recipe = Recipe.find :first, :conditions => {:code => header[2], :active => true}
            unless @previous_version_recipe.nil? 
              @previous_version_recipe.active = false
              @previous_version_recipe.save
            end
            file_imported += 1
            @recipe = Recipe.new :code=>header[2], :name=>header[3].strip(), :version=>header[1]
            logger.debug("Creando encabezado de receta #{@recipe.inspect}")

            while (true)
              item = fd.gets()
              break if item.nil?
              item = item.split(';')
              logger.debug("  * Ingrediente: #{item.inspect}")
              break if item.length == 1
              return false unless validate_field(item[0], 'D')
              @recipe.add_ingredient(
                :amount=>item[3].to_f,
                :priority=>item[1].to_i,
                :percentage=>0,
                :ingredient=>item[2],
                :overwrite=>overwrite)
            end
            @recipe.total = total.to_f
            @recipe.save
          end
          continue = fd.gets()
          break if continue.nil?
          continue = continue.split(';')
        end
        @last_imported_recipe = LastImportedRecipe.last
        @last_imported_recipe.imported_recipes = file_imported
        @last_imported_recipe.total_recipes = file_total
        @last_imported_recipe.save
        
      end
    rescue Exception => ex
      errors.add(:unknown, ex.message)
      return false
    end
    return true
  end

  def get_total
    total = 0
    ingredients = IngredientRecipe.where(:recipe_id => self.id)
    ingredients.each do |i|
      total+= i.amount
    end
    return total
  end
  
  def to_collection_select
    return "#{self.code} - #{self.name} - V#{self.version}"
  end
  
  def deactivate
    self.active = false
    self.save
  end

  private

  def validate_field(field, value)
    field.strip!()
    if field != value
      errors.add(:upload_file, "Archivo inválido")
      return false
    end
    return true
  end

  def validate_starts_with(field, value)
    field.strip!()
    unless field.start_with?(value)
      errors.add(:upload_file, "Archivo inválido")
      return false
    end
    return true
  end

  def convert_to_float(string)
    value = string.strip().gsub('.', '')
    value = value.gsub(',', '.')
    return value.to_f
  end

  def self.search(search, page, per_page)
    if search and search != ""
      paginate :all, :page => page,
               :per_page => per_page,
               :conditions => ['code = ? and active = true', search]
    else
      paginate :all, :page => page, :per_page => per_page, :conditions => ['active = true']
    end
  end
end
