# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

class Customer < ActiveRecord::Base
  belongs_to :company
  belongs_to :shop
  
  has_many    :reservations, :dependent=>:destroy

  def age(calcDay = Time.now)
    return nil if self.birthday.blank?
    (calcDay.strftime("%Y%m%d").to_i-self.birthday.strftime("%Y%m%d").to_i)/10000
  end
  
  ###
  ##  Happy Birthday
  #
  def is_happy_birthday?(probe_date=Time.now.to_date)
    return false if self.birthday.blank?
    
    this_birthday = (Time.mktime(probe_date.year, self.birthday.month, self.birthday.day).to_date)
    next_birthday = this_birthday>>12
 
    range_from  = probe_date-BIRTHDAY_BIAS_DAYS   
    range_until = probe_date+BIRTHDAY_BIAS_DAYS   

    return true if range_from <= this_birthday && this_birthday <= range_until
    return true if range_from <= next_birthday && next_birthday <= range_until
    
    return false
  end

end
