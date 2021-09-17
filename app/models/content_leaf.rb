# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

#hikary#class ContentLeaf < ActiveRecord::Base
class ContentLeaf < ApplicationRecord 
  acts_as_list  :scope => :content_category  # For Leaf Of Gallery And Portfolio

  belongs_to    :shop
  belongs_to    :content_bag
  belongs_to    :content_category
  belongs_to    :staff

  has_many  :photos,  :as => :ref, :dependent => :destroy, :order=>"position asc"

  before_save   :before_save
  after_create  :after_create  
  
  attr_accessible  :shop_id, :content_category_id, :content_bag_id, :is_public, :title, :description, :description_2, :description_3, :staff_id, :publish_from, :publish_until, :integer_field
 
  def before_save
    self.content_category = self.content_bag.content_category if self.content_category.blank?
    self.publish_from     = Time.now.to_date  if self.publish_from.blank?
  end

  def after_create
    return unless hash_key.blank?
    self.hash_key = Digest::MD5.hexdigest(self.shop.id.to_s + self.id.to_s + Time.now.to_s)
    self.save!
  end

  def my_content_bag
    bag_root_category = self.content_category.my_bag_root_category
    return bag_root_category.content_bag
  end
  
  
  def self.public_leafs_condition
    today = Time.now.to_date
    c = Condition.new
    c.and "content_leafs.is_public", true
    c.and do | cx |
      cx.or do |cxa|
        cxa.and "content_leafs.publish_from  IS NULL", 'AND', "1=1"
        cxa.and "content_leafs.publish_until IS NULL", 'AND', "1=1"
      end
      cx.or do |cxa|
        cxa.and "content_leafs.publish_from", '<=', today
        cxa.and "content_leafs.publish_until IS NULL", 'AND', "1=1"
      end
      cx.or do |cxa|
        cxa.and "content_leafs.publish_from",   '<=', today
        cxa.and "content_leafs.publish_until",  '>=', today
      end
    end
    c
  end

end
