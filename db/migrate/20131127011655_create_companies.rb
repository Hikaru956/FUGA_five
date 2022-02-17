# -*- encoding : utf-8 -*-
class CreateCompanies < ActiveRecord::Migration[5.2]
  def self.up
    create_table :companies do |t|
      t.string  :alt_id
      t.string  :name

      t.string  :postal
      t.string  :address_1
      t.string  :address_2

      t.string  :telephone_1
      t.string  :telephone_2
      t.string  :fax

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
