# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

#hikaru#class Shop < ActiveRecord::Base
class Shop < ApplicationRecord
  acts_as_mappable  :default_units => :kms, 
                    :default_formula => :sphere, 
                    :distance_field_name => :distance,
                    :lat_column_name => :lat,
                    :lng_column_name => :lng

  acts_as_list  :scope => :company
  acts_as_tree  :order => :position

  belongs_to    :company
  
  belongs_to    :wsite_color_deploy,    :class_name=>'ColorScheme',   :foreign_key => 'wsite_color_deploy_id', optional: true
  belongs_to    :wsite_color_edit,      :class_name=>'ColorScheme',   :foreign_key => 'wsite_color_edit_id', optional: true
  belongs_to    :wsite_layout_deploy,   :class_name=>'LayoutScheme',  :foreign_key => 'wsite_layout_deploy_id', optional: true
  belongs_to    :wsite_layout_edit,     :class_name=>'LayoutScheme',  :foreign_key => 'wsite_layout_edit_id', optional: true
  #hikaru
  has_many      :staffs,              :dependent=>:destroy #,:order => "position asc"  
  has_many      :users,               :dependent=>:destroy  #, :order => "role desc, login asc"  
  has_many      :customers,           :dependent=>:destroy #, :order => "alt_id asc, furigana asc"

  has_many      :photos,              :dependent=>:destroy

  accepts_nested_attributes_for :photos

  has_many      :web_pages,           :dependent=>:destroy
  has_many      :content_bags,        :dependent=>:destroy
  has_many      :content_leafs,       :dependent=>:destroy  #:order=>'publish_from desc, created_at desc'
  has_many      :content_categories,  :dependent=>:destroy
  
  has_many      :attendances,         :dependent=>:destroy #, :order=>'attend_on asc'
  has_many      :reservations,        :dependent=>:destroy #, :order=>'reserved_on asc'
  has_many      :roster_labels,       :dependent=>:destroy
  
  has_many      :visual_widget_bags,  :dependent=>:destroy

  #hikaru
  #attr_accessible :alt_id, :name, :business_hour_from, :business_hour_until, :postal, :address_1, :wsite_run_mode, :wsite_keywords, :wsite_description_shop, :wsite_description_business, :wsite_telephone, :telephone_1, :wsite_email, :google_calendar_url, :google_calendar_emb_frame_code, :wsite_layout_pc_specific_basename, :social_facebook_uri, :social_gplus_uri, :social_twitter_uri, :social_pinterest_uri, :social_tumblr_uri, :social_instagram_uri, :use_disqus, :disqus_code, :wsite_ga_code, :analytics_code, :custom_metas, :copyright_notice
  
  WSITE_BLOCKED   = 0
  WSITE_TRIAL     = 10
  WSITE_PUBLISHED = 100

  before_create   :before_create
  after_create    :after_create
  after_save      :after_save

  def before_create
    default_color   = ColorScheme.default_scheme
    default_layout  = LayoutScheme.default_scheme

    self.wsite_color_deploy  = default_color
    self.wsite_color_edit    = default_color
    self.wsite_layout_deploy = default_layout
    self.wsite_layout_edit   = default_layout

    self.room_size_mb    = ROOM_SIZE_MB_INIT
  end
  
  def after_create
    WebPage.initialize_rooms_for(self)
  end

  def after_save
    if wsite_hash_key.blank?
      self.wsite_hash_key = gen_new_wsite_key
      self.save!
    end
  end
  
  def gps?
    return (self.lat.blank? || self.lng.blank?)? false: true
  end

  def valid_staffs
    self.staffs.where("staffs.staff_status !=?", Staff::STAFF_BLOCKED)
    #c = Condition.new
    #c.and "staffs.staff_status", '!=', Staff::STAFF_BLOCKED
    #self.staffs.find(:all, :conditions=>c.where)
  end

  def operation_from(probe_date=nil)
    probe_date = Time.now.to_date if probe_date.blank?
    Time.mktime(probe_date.year, probe_date.month, probe_date.day, self.business_hour_from,  0,0)
  end

  def operation_until(probe_date=nil)
    from_time = operation_from(probe_date)
    from_time + ((self.business_hour_until-self.business_hour_from)*60*60)
  end

  ###
  ##  Content Management
  #
  #hikaru
  def web_page_root
    self.web_pages.where("parent_id IS NULL AND page_type=?", WebPage::TYPE_ROOT).first
  end

  def category_type_root_for(content_type)
    type_root = ContentCategory.type_root(self, content_type)    
    return (type_root.blank?)?  nil:  type_root.children
  end

  ###
  ##  Authoring Function
  #
  def authoring_layout; return self.wsite_layout_edit.asset_top;    end
  def renderer_layout;  return self.wsite_layout_deploy.asset_top;  end

  def layout_pc_specific_basename
    return nil if self.wsite_layout_pc_specific_basename.blank?
    LayoutScheme.asset_root+"/"+self.wsite_layout_pc_specific_basename
  end

  def layout_for(author_mode=nil);
    return renderer_layout  if author_mode.blank? || author_mode==false
    author_layout
  end
    
  def color_for(author_mode=nil)
    return renderer_colors  if author_mode.blank? || author_mode==false
    author_colors
  end
    
  def author_layout;  (has_active_layout?)?  self.wsite_layout_edit:  self.wsite_layout_deploy;   end
  def author_colors;  (has_active_colors?)?  self.wsite_color_edit:   self.wsite_color_deploy;    end

  def has_active_layout?; return (self.wsite_layout_edit.blank?)? false: true;  end
  def has_active_colors?; return (self.wsite_color_edit.blank?)?  false: true;  end

  #
  # BC Range
  #
  # bc_month_range_from <= probe_date < bc_month_range_until
  #
  def self.bc_month_range_from(probe_date, bc_day=1)
    bc_closed_date = bc_month_range_until(probe_date, bc_day)
    return (((bc_closed_date.to_date)<<1)+1).to_time    
  end
  
  def self.bc_month_range_until(probe_date, bc_day=1)
    ref_bc_day = Date.new(probe_date.year, probe_date.month, bc_day)
    
    bc_closed_date = Time.mktime(ref_bc_day.year, ref_bc_day.month, ref_bc_day.day)
    bc_closed_date = ((bc_closed_date.to_date)>>1)  if bc_closed_date.to_date < probe_date.to_date
    
    return Time.mktime(bc_closed_date.year, bc_closed_date.month, bc_closed_date.day, 23,59,59)
  end

  def self.snap_bc_date(probe_date, bc_day=1)
    ref_bc_day = Date.new(probe_date.year, probe_date.month, bc_day)
    ref_bc_day = ref_bc_day >> 1 if probe_date.to_date > ref_bc_day
    return Time.mktime(ref_bc_day.year, ref_bc_day.month, ref_bc_day.day)
  end

  ###
  ##  Renderer Utility
  #
  def default_navigation_item
    root = self.content_categories.find_by_category_type(ContentCategory::TYPE_SHOP_ROOT)
    #root.children.find(:first, :conditions=>["is_public=?", true], :order=>"position asc")
    root.children.where(is_public: true).order(position: :asc).first
  end

  def public_navigation_items
#    root = self.content_categories.find_by_category_type(ContentCategory::TYPE_SHOP_ROOT)
    root = WebPage.get_root_node(self)
    #root.children.find(:all, :conditions=>["is_public=?", true], :order=>"position asc")
    root.children.where(is_public: true).order(position: :asc)
  end

  def public_siblings
    #self.company.shops.find(:all, :conditions=>["id!=? AND wsite_run_mode=?", self.id, WSITE_PUBLISHED])
    self.company.shops.where("id!=? AND wsite_run_mode=?", self.id, WSITE_PUBLISHED)
  end

  def public_staffs
    #self.staffs.find(:all, :conditions=>["staff_status!=?", Staff::STAFF_BLOCKED])
    self.staffs.where("staff_status!=?", Staff::STAFF_BLOCKED)
  end

  def favicon
    WebPage.favicon(self)
  end

  def apple_touch_icon
    WebPage.apple_touch_icon(self)
  end

  def photo_size
    #hikaru

    photo_sum_size = 0
    self.photos.each{ |photo|  photo_sum_size+=photo.file_size } unless self.photos.blank?
    photo_sum_size
  end

  def disqus?
    return false unless self.use_disqus
    return false if     self.disqus_code.blank?
    true
  end

  def public_leafs
    today = Time.now.to_date
    leaves = self.content_leafs.eager_load(:content_category).where('content_categories.is_public=TRUE AND content_leafs.is_public=TRUE')
    leaves = Shop.filter_latest(leaves)
    #leaves = leaves.where('   (content_leafs.publish_from IS NULL AND content_leafs.publish_until IS NULL)
    #                      OR  (content_leafs.publish_from <= ? AND content_leafs.publish_until IS NULL)
    #                      OR  (content_leafs.publish_from <= ? AND content_leafs.publish_until >= ?)', \
    #                      today, today, today)
    leaves
  end

  def self.filter_latest(items, today = Time.now.to_date)
    items = items.where("content_leafs.is_public", true)
    items = items.where('     (content_leafs.publish_from IS NULL AND content_leafs.publish_until IS NULL) 
                          OR  (content_leafs.publish_from <= ? AND content_leafs.publish_until IS NULL) 
                          OR  (content_leafs.publish_from <= ? AND content_leafs.publish_until >= ?)', \
                          today, today, today)
    items
  end


  protected 
  def gen_new_wsite_key
    string = Time.now.to_s+":"
    string << self.id.to_s
    string << "*"
    string << self.name     unless self.name.blank?
    return Digest::MD5.hexdigest(string)
  end

end
