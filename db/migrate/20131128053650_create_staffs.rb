# -*- encoding : utf-8 -*-
class CreateStaffs < ActiveRecord::Migration[5.2]
  def self.up
    create_table :staffs do |t|
      t.integer :shop_id
      t.integer :position
      
      t.string  :alt_id
      t.string  :name
      t.string  :job_title
      t.text    :description

      t.integer :staff_status,  :default=>Staff::STAFF_PROPER
      
      t.string  :social_facebook_uri
      t.string  :social_gplus_uri
      t.string  :social_twitter_uri
      t.string  :social_blogger_uri
      t.string  :social_pinterest_uri
      t.string  :social_tumblr_uri

      t.timestamps
    end
  end

  def self.down
    drop_table :staffs
  end
end
