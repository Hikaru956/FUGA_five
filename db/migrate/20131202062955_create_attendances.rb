# -*- encoding : utf-8 -*-
class CreateAttendances < ActiveRecord::Migration[5.2]
  def self.up
    create_table :attendances do |t|
      t.integer  :shop_id
      t.integer  :staff_id
      
      t.date  :attend_on
      t.integer  :start_hour
      t.integer  :until_hour
      t.integer  :attend_period
      
      t.timestamps

    end
    add_index :attendances, :shop_id
    add_index :attendances, :staff_id
    add_index :attendances, :attend_on
  end

  def self.down
    drop_table :attendances
  end
end
