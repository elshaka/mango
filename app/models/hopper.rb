class Hopper < ActiveRecord::Base
  has_many :hopper_lot
  has_many :batch

  validates_uniqueness_of :number
  validates_presence_of :number
  validates_numericality_of :number, :only_integer => true, :greater_than_or_equal_to => 0

  def self.find_active
    actives = {}
    hoppers = Hopper.find :all, :order => 'number ASC'
    hoppers.each do |hop|
      lots = HopperLot.find :first, :conditions => ['hopper_id = ? and active = ?', hop.id, true]
      actives[hop.number] = {
        :lot => lots,
        :hopper_id => hop.id
      }
    end
    return actives
  end

  def self.actives_to_select
    actives = []

    hoppers = Hopper.find :all, :order => 'number ASC'
    hoppers.each do |hop|
      lots = HopperLot.find :first, :conditions => ['hopper_id = ? and active = ?', hop.id, true]
      next if lots.nil?
      actives << ["#{hop.number} - Lote: #{lots.lot.code}", hop.id]
    end
    return actives
  end

  def deactivate_all_lots
    self.hopper_lot.each do |i|
      i.active = false
      i.save
    end
  end

  def update_lot(id)
    deactivate_all_lots
    return true if id.blank?
    h = HopperLot.new(:lot_id => id)
    h.hopper_id = self.id
    return h.save
  end

  def eliminate
    self.hopper_lot.each do |i|
      i.destroy
    end
    self.destroy
  end
end