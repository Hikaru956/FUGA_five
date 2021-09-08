# -*- encoding : utf-8 -*-
class CreateReservations < ActiveRecord::Migration
  def self.up
    create_table :reservations do |t|
      t.integer     :customer_id
      t.integer     :shop_id
      t.integer     :staff_id

      t.timestamp   :reserved_on
      t.timestamp   :reserved_until
      t.integer     :min_period

      t.text        :memo_1
      t.text        :memo_2

      t.timestamps
    end
    add_index :reservations, :shop_id
    add_index :reservations, :customer_id
  end

  def self.down
    drop_table :reservations
  end
end
