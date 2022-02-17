# -*- encoding : utf-8 -*-
class AddCopyrightNoticeForShop < ActiveRecord::Migration[5.2]
  def up
    add_column(:shops, :copyright_notice, :string)
  end

  def down
    remove_column(:shops, :copyright_notice)
  end
end
