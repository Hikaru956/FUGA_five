class AddWebReservationLinkUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :web_reservation_uri, :string
    add_column :staffs, :web_reservation_uri, :string
  end
end
