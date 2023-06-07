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
  acts_as_taggable_on :tags

  belongs_to    :shop
  belongs_to    :content_bag
  belongs_to    :content_category, optional: true
  belongs_to    :staff, optional: true

  #has_many  :photos,  :as => :ref, :dependent => :destroy #hikaru, :order=>"position asc"

  has_many      :photos, ->{order('photos.position ASC')},  as: :ref, :dependent => :destroy

  accepts_nested_attributes_for :photos

  before_save   :before_save
  after_create  :after_create
  
  #attr_accessible  :shop_id, :content_category_id, :content_bag_id, :is_public, :title, :description, :description_2, :description_3, :staff_id, :publish_from, :publish_until, :integer_field

  #labeau.co.jp2対応
  attribute :type, :string, default: nil
  attribute :label, :string, default: nil

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
  
  def self.public_leafs
    today = Time.now.to_date
    leaves = ContentLeaf.eager_load(:content_category).where('content_categories.is_public=TRUE AND content_leafs.is_public=TRUE')
    leaves = filter_latest(leaves)
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

  def next_leaf(leaf)
    today = Time.now.to_date
    category = leaf.content_category
    items = category.content_leafs.where("content_leafs.is_public", true)
    items = items.where('content_leafs.created_at > ?',leaf.created_at)
    items = items.where('     (content_leafs.publish_from IS NULL AND content_leafs.publish_until IS NULL) 
                          OR  (content_leafs.publish_from <= ? AND content_leafs.publish_until IS NULL) 
                          OR  (content_leafs.publish_from <= ? AND content_leafs.publish_until >= ?)', \
                          today, today, today)

    item = (items.blank?)? nil: items.to_a.sort{|a,b| a.created_at <=> b.created_at}.first

    item
  end

  def prev_leaf(leaf)
    today = Time.now.to_date
    category = leaf.content_category
    items = category.content_leafs.where("content_leafs.is_public", true)
    items = items.where('content_leafs.created_at < ?',leaf.created_at)
    items = items.where('     (content_leafs.publish_from IS NULL AND content_leafs.publish_until IS NULL) 
                          OR  (content_leafs.publish_from <= ? AND content_leafs.publish_until IS NULL) 
                          OR  (content_leafs.publish_from <= ? AND content_leafs.publish_until >= ?)', \
                          today, today, today)

    item = (items.blank?)? nil: items.to_a.sort{|a,b| b.created_at <=> a.created_at}.first

    item
  end
  #hikaru
  #def self.public_leafs
  #  today = Time.now.to_date
  #  c = Condition.new
  #  c.and "content_leafs.is_public", true
  #  c.and do | cx |
  #    cx.or do |cxa|
  #      cxa.and "content_leafs.publish_from  IS NULL", 'AND', "1=1"
  #      cxa.and "content_leafs.publish_until IS NULL", 'AND', "1=1"
  #    end
  #    cx.or do |cxa|
  #      cxa.and "content_leafs.publish_from", '<=', today
  #      cxa.and "content_leafs.publish_until IS NULL", 'AND', "1=1"
  #    end
  #    cx.or do |cxa|
  #      cxa.and "content_leafs.publish_from",   '<=', today
  #      cxa.and "content_leafs.publish_until",  '>=', today
  #    end
  #  end
  #  c
  #end

end
