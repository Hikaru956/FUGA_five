# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

require 'digest/sha1'

class User < ActiveRecord::Base
  belongs_to  :company, optional: true
  belongs_to  :shop, optional: true

  validates_uniqueness_of :login

  #hikaru
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :encryptable, :encryptor => :restful_authentication_sha1
  #include ::Authentication
  #include ::Authentication::ByPassword
  #include ::Authentication::ByCookieToken

  #validates :login, :presence   => true,
  #                  :uniqueness => true,
  #                  :length     => { :within => 3..40 },
  #                  :format     => { :with => Authentication.login_regex, :message => Authentication.bad_login_message }

  #validates :name,  :format     => { :with => Authentication.name_regex, :message => Authentication.bad_name_message },
  #                  :length     => { :maximum => 100 },
  #                 :allow_nil  => true


  
#  validates_presence_of     :email
#  validates_uniqueness_of   :email
#  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message, :allow_nil => true
#  validates_length_of       :email,    :within => 6..100 #r@a.wk

  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  
  
  #hikaru
  #attr_accessible :login, :email, :name, :password, :password_confirmation, :role, :company_id, :shop_id

  ROLE_SUPER      = 1000
  ROLE_OPERATOR   = 600
  ROLE_SALES      = 500
  ROLE_REGISTRAR  = 400
  ROLE_OWNER      = 100
  ROLE_MANAGER    = 50
  ROLE_BLOGGER    = 5
  ROLE_BLOCKED    = -1

  def active_for_authentication?
    super && is_proper?
  end

  def is_proper?
    self.role != User::ROLE_BLOCKED
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def email_required?
    false
  end

  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    (u && u.authenticated?(password) && u.role!=User::ROLE_BLOCKED) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  #hikaru
  #def has_permission?(required_role); self.role <= required_role; end
  def has_permission?(req_role)
    req_role <= self.role
  end

  def ui_version
    true
  end

  def is_fuga_3?
    (is_fuga_5?)? false: true
  end

  def is_fuga_5?
    (self.ui_version.blank? || self.ui_version==0)? false: true
  end

  def banned?
    self.try_count>=USER_AUTH_FAIL_COUNT
  end

end
