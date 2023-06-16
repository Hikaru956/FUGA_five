class AddEnableTagsInShop < ActiveRecord::Migration[5.2]
  def change
    add_column    :shops, :enable_tag, :boolean, default: false
    add_column    :shops, :enable_editor, :boolean, default: false
  end
end
