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
#class ContentBag < ActiveRecord::Base
class ContentBag < ApplicationRecord  
  acts_as_list :scope => :parent
  acts_as_tree :order => :position

  belongs_to    :shop
  belongs_to    :web_page     
  belongs_to    :content_category, optional: true

  #hikaru
  has_many      :content_leafs, :dependent=>:destroy #, :order=>'publish_from desc, created_at desc'

  TYPE_NEWS       = 18
  TYPE_STREAM     = 28
  TYPE_GALLERY    = 38
  TYPE_PORTFOLIO  = 48
  TYPE_ANONYMOUS  = 58
  
  #hikari
  #attr_accessible :content_type, :content_category_id, :web_page_id, :shop_id, :is_public, :name
  
  
  before_save   :before_save
  after_save    :after_save
  after_create  :after_create
  
  def before_save
  end

  def after_create
    ContentCategory.register_content_bag(self)
    if self.hash_key.blank?
      self.hash_key = Digest::MD5.hexdigest(self.shop.id.to_s + self.id.to_s + Time.now.to_s)
      self.save!
    end
  end

  def after_save
    self.content_category.is_public = self.is_public
    self.content_category.save!
  end

  def self.type_root(shop, content_type)
    shop.content_bags.find_by(content_type: content_type)
  end

  ###
  ## FIXED PAGE FEATURE
  #
  def self.retrieve_fixed_page_bag(target_shop)
    bag = target_shop.content_bags.find_by_content_type(ContentBag::TYPE_ANONYMOUS)#hikaru, :limit=>1)
    if bag.blank?
      shop_root = ContentCategory.shop_root(target_shop)
      cat = ContentCategory.create(:category_type=>ContentCategory::TYPE_ANONYMOUS,  :shop_id=>target_shop.id, :parent_id=>shop_root.id, :web_page_id=>nil, :title=>CONTENT_CATEGORY_TITLE_ANONYMOUS)
      bag = ContentBag.create(:content_type=>ContentBag::TYPE_ANONYMOUS, :content_category_id=>cat.id, :web_page_id=>nil,  :shop_id=>target_shop.id, :is_public=>true, :name=>CONTENT_CATEGORY_TITLE_ANONYMOUS)
    end
    bag
  end

end
