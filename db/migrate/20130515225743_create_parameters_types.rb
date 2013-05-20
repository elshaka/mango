class CreateParametersTypes < ActiveRecord::Migration
  def self.up
    create_table :parameters_types do |t|
      t.string :name, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :parameters_types
  end
end
