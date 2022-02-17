# -*- encoding : utf-8 -*-
class CreateContentCategories < ActiveRecord::Migration[5.2]
  def self.up
    create_table :content_categories do |t|
      t.integer   :shop_id
      t.integer   :parent_id
      t.integer   :position

      t.integer   :category_type          # SHOP_ROOT | CONTENT_BAG_TYPE | BAG_ROOT   | CATEGORY
      t.integer   :web_page_id         

      t.string    :title
      t.text      :description
      t.text      :description_2
      t.text      :description_3

      t.integer   :integer_field
      t.integer   :integer_field_2
      t.integer   :integer_field_3
      
      t.boolean   :is_public,  :default=>true

      t.timestamps
    end
  end

  def self.down
    drop_table :content_categories
  end
end
