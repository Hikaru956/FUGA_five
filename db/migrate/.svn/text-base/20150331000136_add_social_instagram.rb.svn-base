# -*- encoding : utf-8 -*-
class AddSocialInstagram < ActiveRecord::Migration
  def up
    add_column(:shops,  :social_instagram_uri, :string)
    add_column(:staffs, :social_instagram_uri, :string)
  end

  def down
    remove_column(:shops,   :social_instagram_uri)
    remove_column(:staffs,  :social_instagram_uri, :string)
  end
end
