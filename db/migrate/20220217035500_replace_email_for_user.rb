class ReplaceEmailForUser < ActiveRecord::Migration[5.2]
  def self.up
    add_column    :users, "email_org", :string

    User.all.each do |user|
      user.email_org = user.email
      user.email = user.login unless user.login.blank?
      user.save(validate: false)
    end
  end
  def self.down
    remove_column :users, "email_org"
  end
end
