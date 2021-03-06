class CreateAlarmTypes < ActiveRecord::Migration
  def self.up
    create_table :alarm_types do |t|
      t.string :code
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :alarm_types
  end
end
