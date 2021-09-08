# -*- encoding : utf-8 -*-
class CreateWebPages < ActiveRecord::Migration
  def self.up
    create_table :web_pages do |t|
      t.integer  :shop_id
      t.integer  :parent_id
      t.integer  :position

      t.integer  :content_type      # STREAM | GALLERY | PORTFOLIO 

      t.integer  :page_type         # ROOT | PAGE
      t.integer  :template_name     # HOME | STREAM | GALLERY | CATALOG | INFO | ${ANY UNIQUE TEMPLATE NAME} | FRAME | FIX

      t.string   :controller_name,  :default=>'bs_renderer' # bs_rendeter
      t.string   :action_name                               # home | stream_root | gallery_root | catalog_root | blank
      t.string   :content_key,      :default=>nil

      t.string   :name
      t.boolean  :is_public,        :default=>true
      t.string   :external_url,     :default=>nil
      t.boolean  :is_open_new,      :default=>false
      
      t.text     :frame_code
      
      t.timestamps
    end
  end

  def self.down
    drop_table :web_pages
  end
end
