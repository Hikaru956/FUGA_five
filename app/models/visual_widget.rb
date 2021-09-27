# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

#hikaru#class VisualWidget < ActiveRecord::Base
class VisualWidget < ApplicationRecord
  acts_as_list  :scope => :layout_scheme
  
  belongs_to    :layout_scheme
  
  has_many      :visual_widget_bags,  :dependent=>:destroy
  
  #attr_accessible :layout_scheme_id, :widget_type, :title, :description

  WIDGET_TYPE_STRING    = 10
  WIDGET_TYPE_TEXT      = 20
  WIDGET_TYPE_CODE      = 30
  WIDGET_TYPE_LINK      = 40
  WIDGET_TYPE_PHOTO     = 50
  WIDGET_TYPE_PHOTOS    = 60

  after_save  :after_save

  def after_save
    if self.hash_key.blank?
      self.hash_key = gen_new_hash_key
      self.save!
    end
  end

  def get_bag_for(target_shop)
    self.visual_widget_bags.find_by_shop_id(target_shop.id)    
  end
  
  def self.search_widget_bag_for(shop, hash_key)
    widget = VisualWidget.find_by_hash_key(hash_key)
    return nil if widget.blank?
    return widget.visual_widget_bags.find_by_shop_id(shop.id)
  end

  protected
  def gen_new_hash_key
    string = "FUGA"
    string << self.id.to_s
    return Digest::MD5.hexdigest(string)
  end

end
