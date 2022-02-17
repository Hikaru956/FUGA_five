# -*- encoding : utf-8 -*-
class AddSomeWebPropertiesForShop < ActiveRecord::Migration[5.2]
  def up
    add_column(:shops, :analytics_code, :text)
    add_column(:shops, :custom_metas,   :text)
  end

  def down
    remove_column(:shops, :analytics_code)
    remove_column(:shops, :custom_meta)
  end
end
