class AddColumnShop < ActiveRecord::Migration[5.2]
  def change
#    add_column :shops, :social_line_uri, :string
    add_column :shops, :social_hotpepper_beauty_uri, :string
    add_column :shops, :social_youtube_uri, :string
  end
end
