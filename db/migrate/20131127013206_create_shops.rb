# -*- encoding : utf-8 -*-
class CreateShops < ActiveRecord::Migration[5.2]
  def self.up
    create_table :shops do |t|
      t.integer :company_id
      t.integer :position
      t.integer :parent_id
      
      t.string  :alt_id
      t.string  :name

      t.string  :postal
      t.string  :address_1
      t.string  :address_2

      t.string  :telephone_1
      t.string  :telephone_2
      t.string  :fax

      t.integer :business_hour_from,  :default=>9
      t.integer :business_hour_until, :default=>21

      t.float   :lat,   :default=>nil             ### SHOULD BE DOUBLE
      t.float   :lng,   :default=>nil             ### SHOULD BE DOUBLE

      t.boolean :option_attendance_management,  :default=>false
      t.boolean :option_customer_management,    :default=>false
      t.boolean :option_reservation_management, :default=>false
      t.boolean :option_sales_management,       :default=>false

      t.integer :room_size_mb,                  :default=>nil

      t.integer :wsite_run_mode,                :default=>Shop::WSITE_TRIAL
      t.string  :wsite_hash_key

      t.integer :wsite_color_deploy_id,             :default=>nil
      t.integer :wsite_layout_deploy_id,            :default=>nil
      t.integer :wsite_color_edit_id,               :default=>nil
      t.integer :wsite_layout_edit_id,              :default=>nil

      t.string  :wsite_layout_pc_specific_basename, :default=>nil

      t.string  :wsite_keywords
      t.text    :wsite_description_shop
      t.text    :wsite_description_business
      t.string  :wsite_telephone
      t.string  :wsite_email
      
      t.string  :social_facebook_uri
      t.string  :social_gplus_uri
      t.string  :social_twitter_uri
      t.string  :social_blogger_uri
      t.string  :social_pinterest_uri
      t.string  :social_tumblr_uri

      t.string  :google_calendar_url
      t.text    :google_calendar_emb_frame_code
      
      t.string  :wsite_ga_code

      t.timestamps
    end
    add_index :shops, :wsite_hash_key
  end

  def self.down
    drop_table :shops
  end
end
