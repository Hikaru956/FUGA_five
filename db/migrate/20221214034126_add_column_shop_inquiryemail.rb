class AddColumnShopInquiryemail < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :inquiry_email, :string
  end
end
