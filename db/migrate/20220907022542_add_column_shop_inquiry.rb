class AddColumnShopInquiry < ActiveRecord::Migration[5.2]
  def change
    add_column    :shops, :enable_inquiry, :boolean, default: false
  end
end
