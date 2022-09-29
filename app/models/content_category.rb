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
#class ContentCategory < ActiveRecord::Base
class ContentCategory < ApplicationRecord  
  acts_as_list :scope => :parent
  acts_as_tree :order => :position

  belongs_to    :shop
  #belongs_to    :content_bag, optional: true
  belongs_to    :web_page, optional: true
  has_many      :content_leafs, ->{order('content_leafs.publish_from DESC, content_leafs.created_at DESC')}, :dependent=>:nullify
  has_one       :content_bag,   :dependent=>:destroy
  
  #hikaru
  has_many  :photos, ->{order('photos.position ASC')},  :as => :ref, :dependent => :destroy

  accepts_nested_attributes_for :photos

  TYPE_SHOP_ROOT        = 0
  TYPE_HOME             = WebPage::TYPE_HOME
  TYPE_INFO             = WebPage::TYPE_INFO
  TYPE_NEWS             = ContentBag::TYPE_NEWS
  TYPE_STREAM           = ContentBag::TYPE_STREAM
  TYPE_GALLERY          = ContentBag::TYPE_GALLERY
  TYPE_PORTFOLIO        = ContentBag::TYPE_PORTFOLIO
  TYPE_ANONYMOUS        = ContentBag::TYPE_ANONYMOUS
  TYPE_BAG_ROOT         = 100
  TYPE_CATEGORY         = 1000
  
  #hikaru
  #attr_accessible  :category_type, :shop_id, :parent_id, :web_page_id, :title, :description

  before_save :before_save
  
  def before_save
    self.shop = parent.shop if self.shop.blank?
  end
  
  def self.register_content_bag(content_bag)
    return content_bag.content_category unless content_bag.content_category.blank?

    parent = type_root(content_bag.shop, content_bag.content_type) 
    content_bag.content_category = 
      ContentCategory.create(:category_type=>TYPE_BAG_ROOT, :web_page_id=>(content_bag.web_page.blank?)? nil: content_bag.web_page.id, :shop_id=>content_bag.shop.id, :parent_id=>parent.id, :title=>"TYPE_BAG_ROOT")
    content_bag.save  
    content_bag.content_category
  end
  
  def self.type_root(target_shop, content_type)
    #target_shop.content_categories.find(:first, :conditions=>["shop_id=? AND category_type=?", target_shop.id, content_type])
    target_shop.content_categories.where('shop_id=? AND category_type=?', target_shop.id, content_type).first
  end
  
  def as_json options = {}
    super :methods => ['text'],
          :only =>['id', 'parent', 'text', 'children'],
          :include => {
            :children => { :methods => ['text'], :only =>['id', 'parent', 'text', 'children'] }
          }
  end

  def name
    category_label
  end

  def text
    category_label
  end

  def data
    category_label
  end

  def category_label
    return self.shop.name         if self.category_type==ContentCategory::TYPE_SHOP_ROOT
    return "NEWS"                 if self.category_type==ContentCategory::TYPE_NEWS
    return "STREAM"               if self.category_type==ContentCategory::TYPE_STREAM
    return "GALLERY"              if self.category_type==ContentCategory::TYPE_GALLERY
    return "PORTFOLIO"            if self.category_type==ContentCategory::TYPE_PORTFOLIO
    return "ANONYMOUS"            if self.category_type==ContentCategory::TYPE_ANONYMOUS
    return self.content_bag.name     if self.category_type==ContentCategory::TYPE_BAG_ROOT
    return self.title
  end

  def sons
    children = self.children
    my_sons = []
    unless children.blank? 
      my_sons.concat(children)
      children.each { | child | my_sons.concat(child.sons) }
    end
    my_sons
  end

  def category_path(include_me=false)
    ans_array   = Array.new
    ans_array << self if include_me
    self.ancestors.each do |category |
      next if category.category_type<ContentCategory::TYPE_BAG_ROOT
      ans_array << category
    end
    return ans_array.reverse
  end

  def total_leafs
    sons = self.sons
    sons << self

    ContentLeaf.where("content_leafs.content_category_id IN (?)", sons)
    #hikaru
    #c = Condition.new
    #c.and "content_leafs.content_category_id", 'IN', sons
    #ContentLeaf.find(:all, :conditions=>c.where)
  end

  def total_photos
      #c = Condition.new
      sons = self.sons
      sons << self
      leafs = ContentLeaf.where('content_leafs.content_category_id IN (?)', sons)
      photos = Photo.where("photos.ref_type='ContentLeaf' AND photos.ref_id IN (?)", leafs.to_a)
      return photos
      #hikaru
      #c.and "content_leafs.content_category_id", sons unless sons.blank?
      #Photo.find(:all, :conditions=>c.where, :joins=>"inner join content_leafs on (content_leafs.id=photos.ref_id AND photos.ref_type='ContentLeaf')")
  end

  def my_bag_root_category
    return nil  if self.category_type<ContentCategory::TYPE_BAG_ROOT
    return self if self.category_type==ContentCategory::TYPE_BAG_ROOT
    return (self.parent.blank?)? nil: self.parent.my_bag_root_category
  end

  def my_type_root_category
    return nil  if self.category_type<=ContentCategory::TYPE_SHOP_ROOT
    return self if self.category_type<ContentCategory::TYPE_BAG_ROOT
    return (self.parent.blank?)? nil: self.parent.my_type_root_category
  end

  def has_only_a_public_bag?
    type_root = self.my_type_root_category
    return false if type_root.blank?
    type_root.public_bags.size==1
  end

  def self.shop_root(target_shop)
    #target_shop.content_categories.find(:first, :conditions=>["parent_id IS NULL AND category_type=?", TYPE_SHOP_ROOT])
    target_shop.content_categories.where("parent_id IS NULL AND category_type=?", TYPE_SHOP_ROOT).first
  end
  
  def self.type_root(target_shop, content_type)
    target_shop.content_categories.find_by("category_type=?", content_type)

  end

  ###
  ##  Renderer Utility
  #
  def public_bags
    #self.children.find(:all, :conditions=>["category_type=? AND is_public=?", TYPE_BAG_ROOT, true])
    self.children.where("category_type=? AND is_public=?", TYPE_BAG_ROOT, true)
  end
  
  def public_categories
    #self.children.where('is_public=?', true)
    self.children.where('is_public=?', true)
  end
  
  def public_leafs(recurse=false)
    if recurse
      items = ContentLeaf.all
      items = ContentLeaf.eager_load(:content_category).where('content_categories.is_public=TRUE AND content_leafs.is_public=TRUE').filter_latest(items).order(publish_from: :desc).order(created_at: :desc)
      sons = self.sons
      sons << self
      items = items.where("content_leafs.content_category_id IN (?)", sons)
      return items
      
      #c = ContentLeaf.public_leafs
      #c.and "content_leafs.content_category_id", 'IN', sons
      #return ContentLeaf.find(:all, :conditions=>c.where, :order=>'publish_from desc')
    else
      items = ContentLeaf.all
      items = ContentLeaf.filter_latest(items).order(publish_from: :desc).order(created_at: :desc)
      items = items.where("content_leafs.content_category_id =?", self)
      return items
      #return self.content_leafs.find(:all, :conditions=>ContentLeaf.public_leafs.where, :order=>'publish_from desc')
    end
  end
  
  #hikaru
  #def latest_news_article
  #  sons = self.sons
  #  sons << self
  #  c = ContentLeaf.public_leafs
  #  c.and "content_leafs.content_category_id", 'IN', sons
  #  return ContentLeaf.find(:first, :conditions=>c.where, :order=>'position desc')
  #end

  def latest_news_article
    sons = self.sons
    sons << self

    items = ContentLeaf.public_leafs.where("content_leafs.content_category_id IN (?)", sons)
    items = items.order(position: :desc).first
  end
  
end
