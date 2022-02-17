# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

#hikaru#class LayoutScheme < ActiveRecord::Base
class LayoutScheme < ApplicationRecord
  acts_as_list
  
  has_many  :wsite_layout_deploys, :class_name=>'Shop', :foreign_key => 'wsite_layout_deploy_id'
  has_many  :wsite_layout_edits,   :class_name=>'Shop', :foreign_key => 'wsite_layout_deploy_id'

  has_many  :visual_widgets, :dependent => :destroy #, :order=>"position asc"

  has_one   :photo,  :as => :ref, :dependent => :destroy

  #attr_accessible :is_public, :name, :description, :repository_path

  before_destroy  :before_destroy


  def self.default_scheme
    LayoutScheme.where("is_public=?",true).order(position: :asc).first
    #LayoutScheme.find(:first, :conditions=>["is_public=?",true], :order=>"position asc")
  end
  
  def self.asset_root
    LAYOUT_ASSETS
  end
  
  def asset_top
    LayoutScheme.asset_root+'/'+self.repository_path
  end
  
  def before_destroy
    default_scehme = LayoutScheme.default_scheme
    #default_scehme = LayoutScheme.where("id!=? AND is_public =?",self.id, true).order(position: :asc).first
    #default_scehme = LayoutScheme.find(:first, :conditions=>["id!=? AND is_public=?", self.id, true], :order=>"position asc")

    Shop.where('wsite_layout_deploy_id =?',self.id).each do | site |
      site.wsite_layout_deploy = default_scehme
      site.save!
    end
    Shop.where('wsite_layout_edit_id =?',self.id).each do | site |
      site.wsite_layout_edit = default_scehme
      site.save!
    end
  end

  def self.verify_visual_widget(layout_scheme, shop)
    layout_scheme.visual_widgets.each do | widget |
      my_bag = widget.visual_widget_bags.find_by_shop_id(shop.id)
      if my_bag.blank?
        new_bag = VisualWidgetBag.new
        new_bag.shop = shop
        new_bag.visual_widget = widget
        new_bag.save!
      end
    end
  end

end
