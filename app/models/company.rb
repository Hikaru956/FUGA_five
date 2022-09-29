# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

#hikaru
#class Company < ActiveRecord::Base
class Company < ApplicationRecord  
  #hikaru
  has_many    :users, ->{order('users.role DESC, users.login ASC')},  :dependent=>:destroy
  has_many    :shops, ->{order('shops.position ASC')},  :dependent=>:destroy
  has_many    :customers, ->{order('customers.alt_id ASC, customers.furigana ASC')},  :dependent=>:destroy
  
  #attr_accessible  :alt_id, :name, :telephone_1, :postal, :address_1
  
  def room_size_mb
    sum = 0
    self.shops.each do | shop |
      return nil  if shop.room_size_mb.blank?
      sum += shop.room_size_mb
    end
    sum
  end
  
  def photo_size
    sum = 0
    self.shops.each do | shop |
      sum += shop.photo_size
    end
    sum
  end
  
end
