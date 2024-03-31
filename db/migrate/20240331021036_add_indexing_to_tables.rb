class AddIndexingToTables < ActiveRecord::Migration[5.2]
  def change
    add_index :shops, :company_id

    add_index :content_bags, :shop_id
    add_index :content_bags, :content_category_id

    add_index :content_categories, :shop_id
    add_index :content_categories, :web_page_id

    add_index :content_leafs, :shop_id
    add_index :content_leafs, [:shop_id, :content_bag_id, :content_category_id], name: 'index_content_leaf_stream'
    add_index :content_leafs, :hash_key

    add_index :web_pages, :shop_id
    add_index :web_pages, [:shop_id, :content_type]

  end
end
