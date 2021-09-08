# -*- encoding : utf-8 -*-
class CreateContentBags < ActiveRecord::Migration
  def self.up
    create_table :content_bags do |t|
      t.integer   :shop_id
      t.integer   :parent_id
      t.integer   :position
      t.string    :hash_key

      t.integer   :content_type           # STREAM | GALLERY | PORTFOLIO 
      t.integer   :content_category_id
      t.integer   :web_page_id

      t.string    :name
      t.text      :description
      t.boolean   :is_public,  :default=>false

      t.timestamps
    end
  end

  def self.down
    drop_table :content_bags
  end
end
