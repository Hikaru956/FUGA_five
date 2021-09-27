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
#class ColorScheme < ActiveRecord::Base
class ColorScheme < ApplicationRecord
  acts_as_list

  has_many  :wsite_color_deploys, :class_name=>'Shop', :foreign_key => 'wsite_color_deploy_id'
  has_many  :wsite_color_edits,   :class_name=>'Shop', :foreign_key => 'wsite_color_deploy_id'

  has_one  :photo,  :as => :ref, :dependent => :destroy

  #attr_accessible :is_public, :name, :description, :repository_path

  before_destroy  :before_destroy

  def self.default_scheme
    ColorScheme.find(:first, :conditions=>["is_public=?",true], :order=>"position asc")
  end
  
  def asset_top
    COLOR_ASSETS+'/'+self.repository_path
  end
  
  def before_destroy
    default_scehme = ColorScheme.find(:first, :conditions=>["id!=? AND is_public=?", self.id, true], :order=>"position asc")

    Shop.find_all_by_wsite_color_deploy_id(self.id).each do | site |
      site.wsite_color_deploy = default_scehme
      site.save!
    end
    Shop.find_all_by_wsite_color_edit_id(self.id).each do | site |
      site.wsite_color_edit = default_scehme
      site.save!
    end
  end

end
