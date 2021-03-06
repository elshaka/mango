class Role < ActiveRecord::Base
  attr_protected :id

  has_many :permission_role
  has_many :permissions, :through => :permission_role
  has_one :user

  validates_presence_of :name, :description
  validates_length_of :name, :description, :within => 3..40

  def self.get_all
    find :all, :order => 'name ASC'
  end
end
