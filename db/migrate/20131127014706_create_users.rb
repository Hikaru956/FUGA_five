# -*- encoding : utf-8 -*-
class CreateUsers < ActiveRecord::Migration[5.2]
  def self.up
    create_table "users", :force => true do |t|
      t.string   :login,                     :limit => 40
      t.string   :name,                      :limit => 100, :default => '', :null => true
      t.string   :email,                     :limit => 100
      t.string   :crypted_password,          :limit => 40
      t.string   :salt,                      :limit => 40
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :remember_token,            :limit => 40
      t.datetime :remember_token_expires_at

      t.integer  :role,                      :default=>User::ROLE_BLOGGER
      t.integer  :company_id,                :default=>nil 
      t.integer  :shop_id,                   :default=>nil 

    end
    add_index :users, :login, :unique => true
    
    init_user = User.new
    init_user.name = "956 Inc."
    init_user.login = "rep@956.jp"
    init_user.email = "rep@956.jp"
    init_user.password = "956service"
    init_user.password_confirmation = "956service"
    init_user.role = User::ROLE_SUPER
    init_user.save
    
  end

  def self.down
    drop_table "users"
  end
end
