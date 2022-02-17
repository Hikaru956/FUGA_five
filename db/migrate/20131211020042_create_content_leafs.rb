# -*- encoding : utf-8 -*-
class CreateContentLeafs < ActiveRecord::Migration[5.2]
  def self.up
    create_table :content_leafs do |t|
      t.integer   :shop_id
      t.integer   :content_bag_id
      t.integer   :content_category_id
      t.integer   :staff_id
      t.string    :hash_key

      t.integer   :position

      t.string    :title
      t.text      :description
      t.text      :description_2
      t.text      :description_3

      t.integer   :integer_field
      t.integer   :integer_field_2
      t.integer   :integer_field_3

      t.string    :link_title
      t.text      :link_url
      t.boolean   :is_open_new,      :default=>false
      t.string    :link_title_2
      t.text      :link_url_2
      t.boolean   :is_open_new_2,    :default=>false
      t.string    :link_title_3
      t.text      :link_url_3
      t.boolean   :is_open_new_3,    :default=>false
      
      t.boolean   :is_public,        :default=>false
      t.date      :publish_from
      t.date      :publish_until
      t.boolean   :is_hot,           :default=>false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :content_leafs
  end
end
