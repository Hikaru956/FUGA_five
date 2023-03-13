# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

#hikaru#class WebPage < ActiveRecord::Base
class WebPage < ApplicationRecord
  acts_as_list :scope => :parent
  acts_as_tree :order => :position

  has_one       :content_category
  has_many      :content_bag,       :dependent=>:destroy

  #hikaru
  has_many      :photos, ->{order('photos.position ASC')}, :as => :ref, :dependent => :destroy

  accepts_nested_attributes_for :photos

  belongs_to    :shop
  
  TYPE_ROOT     = 0
  TYPE_PAGE     = 10
  TYPE_FIX      = 20

  TYPE_HOME             = 5
  TYPE_INFO             = 6
  TYPE_NEWS             = ContentBag::TYPE_NEWS
  TYPE_STREAM           = ContentBag::TYPE_STREAM
  TYPE_GALLERY          = ContentBag::TYPE_GALLERY
  TYPE_PORTFOLIO        = ContentBag::TYPE_PORTFOLIO
  TYPE_ANONYMOUS        = ContentBag::TYPE_ANONYMOUS
  TYPE_LINK             = 99
  
  TEMPLATE_HOME       = 'home'
  TEMPLATE_STREAM     = 'stream'
  TEMPLATE_GALLERY    = 'gallery'
  TEMPLATE_PORTFOLIO  = 'portfolio'
  TEMPLATE_INFO       = 'about'
  TEMPLATE_LINK       = 'link'
  TEMPLATE_FRAME      = 'frame'
  TEMPLATE_FIX        = 'fix'
  
  #hikaru
  #attr_accessible :page_type, :shop_id, :parent_id, :template_name, :action_name, :name, :content_type, :is_public, :is_open_new, :external_url
  
  
  def self.initialize_rooms_for(target_shop)
    ###
    ##  Delete current settings.
    #
    root =   ContentCategory.shop_root(target_shop)
    root.delete unless root.blank?
    
    ###
    ##  Build root categories for a shop and its each content bag. 
    #
    root = ContentCategory.create!(:category_type=>ContentCategory::TYPE_SHOP_ROOT, :shop_id=>target_shop.id, :parent_id=>nil, :title=>"SHOP ROOT")
    ###
    ##  'web_page' field will be fixed last, after creating web_pages. 
    #
    cat_home      = ContentCategory.create!(:category_type=>ContentCategory::TYPE_HOME,       :shop_id=>target_shop.id, :parent_id=>root.id, :web_page_id=>nil, :title=>CONTENT_CATEGORY_TITLE_HOME)
    cat_news      = ContentCategory.create!(:category_type=>ContentCategory::TYPE_NEWS,       :shop_id=>target_shop.id, :parent_id=>root.id, :web_page_id=>nil, :title=>CONTENT_CATEGORY_TITLE_NEWS)
    cat_blog      = ContentCategory.create!(:category_type=>ContentCategory::TYPE_STREAM,     :shop_id=>target_shop.id, :parent_id=>root.id, :web_page_id=>nil, :title=>CONTENT_CATEGORY_TITLE_STREAM)
    cat_gallery   = ContentCategory.create!(:category_type=>ContentCategory::TYPE_GALLERY,    :shop_id=>target_shop.id, :parent_id=>root.id, :web_page_id=>nil, :title=>CONTENT_CATEGORY_TITLE_GALLERY)
    cat_portfolio = ContentCategory.create!(:category_type=>ContentCategory::TYPE_PORTFOLIO,  :shop_id=>target_shop.id, :parent_id=>root.id, :web_page_id=>nil, :title=>CONTENT_CATEGORY_TITLE_PORTFOLIO)
    cat_info      = ContentCategory.create!(:category_type=>ContentCategory::TYPE_INFO,       :shop_id=>target_shop.id, :parent_id=>root.id, :web_page_id=>nil, :title=>CONTENT_CATEGORY_TITLE_INFO)
    cat_anonymous = ContentCategory.create!(:category_type=>ContentCategory::TYPE_ANONYMOUS,  :shop_id=>target_shop.id, :parent_id=>root.id, :web_page_id=>nil, :title=>CONTENT_CATEGORY_TITLE_ANONYMOUS)
  
    ###
    ##  Build a new site pages up.
    #
    root = WebPage.create!(:page_type=>TYPE_ROOT, :shop_id=>target_shop.id, :parent_id=>nil)
    
    page_home   = WebPage.create!(:page_type=>TYPE_PAGE, :template_name=>TEMPLATE_HOME,      :action_name=>'home',            :shop_id=>target_shop.id, :parent_id=>root.id, :name=>CONTENT_CATEGORY_TITLE_HOME)
    page_news   = WebPage.create!(:page_type=>TYPE_PAGE, :template_name=>TEMPLATE_STREAM,    :action_name=>'news_index',      :shop_id=>target_shop.id, :parent_id=>root.id, :name=>CONTENT_CATEGORY_TITLE_NEWS,       :content_type=>TYPE_NEWS)
    page_blog   = WebPage.create!(:page_type=>TYPE_PAGE, :template_name=>TEMPLATE_STREAM,    :action_name=>'stream_index',    :shop_id=>target_shop.id, :parent_id=>root.id, :name=>CONTENT_CATEGORY_TITLE_STREAM,     :content_type=>TYPE_STREAM)
    page_glry   = WebPage.create!(:page_type=>TYPE_PAGE, :template_name=>TEMPLATE_GALLERY,   :action_name=>'gallery_index',   :shop_id=>target_shop.id, :parent_id=>root.id, :name=>CONTENT_CATEGORY_TITLE_GALLERY,    :content_type=>TYPE_GALLERY)
    page_prtf   = WebPage.create!(:page_type=>TYPE_PAGE, :template_name=>TEMPLATE_GALLERY,   :action_name=>'portfolio_index', :shop_id=>target_shop.id, :parent_id=>root.id, :name=>CONTENT_CATEGORY_TITLE_PORTFOLIO,  :content_type=>TYPE_PORTFOLIO)
    page_info   = WebPage.create!(:page_type=>TYPE_PAGE, :template_name=>TEMPLATE_INFO,      :action_name=>'contact',         :shop_id=>target_shop.id, :parent_id=>root.id, :name=>CONTENT_CATEGORY_TITLE_INFO)

    ###
    ##  Allocate Content Bag
    #
    ContentBag.create!(:content_type=>ContentBag::TYPE_NEWS,      :web_page_id=>page_news.id,    :shop_id=>target_shop.id, :is_public=>true, :name=>CONTENT_CATEGORY_TITLE_NEWS)
    ContentBag.create!(:content_type=>ContentBag::TYPE_STREAM,    :web_page_id=>page_blog.id,    :shop_id=>target_shop.id, :is_public=>true, :name=>CONTENT_CATEGORY_TITLE_STREAM)
    ContentBag.create!(:content_type=>ContentBag::TYPE_GALLERY,   :web_page_id=>page_glry.id,    :shop_id=>target_shop.id, :is_public=>true, :name=>CONTENT_CATEGORY_TITLE_GALLERY)
    ContentBag.create!(:content_type=>ContentBag::TYPE_PORTFOLIO, :web_page_id=>page_prtf.id,    :shop_id=>target_shop.id, :is_public=>true, :name=>CONTENT_CATEGORY_TITLE_PORTFOLIO)
    ContentBag.create!(:content_type=>ContentBag::TYPE_ANONYMOUS, :web_page_id=>page_info.id,             :shop_id=>target_shop.id, :is_public=>true, :name=>CONTENT_CATEGORY_TITLE_ANONYMOUS)

    ###
    ##  Bind web_page(s) to category root for navigations
    #
    cat_home.web_page      = page_home
    cat_home.save!
    cat_news.web_page      = page_news
    cat_news.save!
    cat_blog.web_page      = page_blog
    cat_blog.save!
    cat_gallery.web_page   = page_glry
    cat_gallery.save!
    cat_portfolio.web_page = page_prtf
    cat_portfolio.save!
    cat_info.web_page      = page_info
    cat_info.save!
  end
  
  def self.get_root_node(target_shop)
    target_shop.web_page_root
  end

  def self.favicon(target_shop)
    old_favicon = WebPage.get_root_node(target_shop).photos.find_by_clip_file_name('favicon.ico')
    return old_favicon unless old_favicon.blank?
    WebPage.get_root_node(target_shop).photos.find_by_clip_file_name('favicon.png')
  end

  def self.apple_touch_icon(target_shop)
    WebPage.get_root_node(target_shop).photos.find_by_clip_file_name('apple-touch-icon-precomposed.png')
  end
  
  def self.reset_favicon(target_shop)
    #Photo.destroy_all(["shop_id=? AND ref_id=? AND ref_type=? AND image=?", target_shop.id, WebPage.get_root_node(target_shop), 'WebPage', 'favicon.ico'])    
    photos = Photo.where("shop_id=? AND ref_id=? AND ref_type=? AND ( clip_file_name=? OR clip_file_name=?)", target_shop.id, WebPage.get_root_node(target_shop), 'WebPage', 'favicon.ico', 'favicon.png')
    photos.destroy_all
  end

  def self.reset_apple_touch_icon(target_shop)
    #Photo.destroy_all(["shop_id=? AND ref_id=? AND ref_type=? AND image=?", target_shop.id, WebPage.get_root_node(target_shop), 'WebPage', 'apple-touch-icon-precomposed.png'])
    photos = Photo.where("shop_id=? AND ref_id=? AND ref_type=? AND image=?", target_shop.id, WebPage.get_root_node(target_shop), 'WebPage', 'apple-touch-icon-precomposed.png')
    photos.destroy_all
  end
end
