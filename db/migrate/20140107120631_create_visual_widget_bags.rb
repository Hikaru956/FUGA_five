# -*- encoding : utf-8 -*-
class CreateVisualWidgetBags < ActiveRecord::Migration[5.2]
  def self.up
    create_table :visual_widget_bags do |t|
      t.integer   :shop_id
      t.integer   :visual_widget_id

      t.string    :data_string,       :default=>nil
      t.text      :data_text
      t.string    :data_url,          :default=>nil
      t.boolean   :data_boolean,      :default=>false
      t.text      :data_code

      t.timestamps
    end
    add_index :visual_widget_bags, :shop_id
    add_index :visual_widget_bags, :visual_widget_id
  end

  def self.down
    drop_table :visual_widget_bags
  end
end
