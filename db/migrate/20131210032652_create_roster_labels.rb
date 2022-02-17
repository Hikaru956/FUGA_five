# -*- encoding : utf-8 -*-
class CreateRosterLabels < ActiveRecord::Migration[5.2]
  def self.up
    create_table :roster_labels do |t|
      t.integer   :shop_id
      t.string    :name
      
      t.integer   :start_hour
      t.integer   :until_hour   
      t.integer   :position

      t.timestamps
    end
  end

  def self.down
    drop_table :roster_labels
  end
end
