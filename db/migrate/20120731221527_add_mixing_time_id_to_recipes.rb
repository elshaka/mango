require 'migration_helper'

class AddMixingTimeIdToRecipes < ActiveRecord::Migration
extend MigrationHelper
  def self.up
    add_column :recipes, :mixing_time_id, :integer
    add_foreign_key :recipes, 'mixing_time_id', :mixing_times
  end

  def self.down
    drop_foreign_key :recipes, 'mixing_time_id'
    remove_column :recipes, :mixing_time_id
  end
end
