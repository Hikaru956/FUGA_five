class AddColumnStaff < ActiveRecord::Migration[5.2]
  def change
    add_column :staffs, :social_line_uri, :string
    add_column :staffs, :social_hotpepper_beauty_uri, :string
    add_column :staffs, :social_youtube_uri, :string
  end
end
