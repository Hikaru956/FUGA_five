# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

class RosterLabel < ActiveRecord::Base
  belongs_to  :shop
  acts_as_list
  
  before_save :before_save
  
  def before_save
    if self.start_hour>self.until_hour
      buf = self.start_hour
      self.start_hour = self.until_hour
      self.until_hour = buf
    end
    self.name = self.shop.alt_id+":"+self.start_hour.to_s+"〜"       if self.name.blank?
  end
end
