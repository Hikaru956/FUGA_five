# -*- encoding : utf-8 -*-
class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.column  :company_id,      :integer, :default => nil
      t.column  :shop_id,         :integer, :default => nil
      t.column  :alt_id,          :string,  :default => nil
      t.column  :name,            :string
      t.column  :furigana,        :string,  :default => nil
      t.column  :email,           :string,  :default => nil
      t.column  :telephone,       :string,  :default => nil
      t.column  :telephone_2,     :string,  :default => nil
      t.column  :postal_code,     :string,  :default => nil
      t.column  :address,         :text
      t.column  :address_2,       :text
      t.column  :birthday,        :date,    :default => nil
      t.column  :created_at,      :timestamp
      t.column  :updated_at,      :timestamp
    end
    add_index :customers, :company_id
    add_index :customers, :shop_id
    add_index :customers, :alt_id
    add_index :customers, :birthday
  end

  def self.down
    drop_table :customers
  end
end
