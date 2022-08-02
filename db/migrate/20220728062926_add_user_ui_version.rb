class AddUserUiVersion < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :ui_version, :integer, optional: :true, default: :nil
  end
end
