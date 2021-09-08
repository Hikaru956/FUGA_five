# -*- encoding : utf-8 -*-
class AddUserTryCount < ActiveRecord::Migration
  def up
    add_column(:users, :try_count, :integer, :default=>0)
  end

  def down
    remove_column(:users, :try_count)
  end
end
