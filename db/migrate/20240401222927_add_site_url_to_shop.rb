class AddSiteUrlToShop < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :wsite_url, :string
  end
end
