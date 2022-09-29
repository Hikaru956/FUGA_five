# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

#hikatru#class VisualWidgetBag < ActiveRecord::Base
class VisualWidgetBag < ApplicationRecord
  belongs_to    :shop
  belongs_to    :visual_widget

  has_many      :photos, ->{order('photos.position ASC')},  :as => :ref, :dependent => :destroy 
  accepts_nested_attributes_for :photos

  #attr_accessible :data_string

  def is_valid?
    if      self.visual_widget.widget_type==VisualWidget::WIDGET_TYPE_STRING
      return (self.data_string.blank?)? false: true 
    elsif   self.visual_widget.widget_type==VisualWidget::WIDGET_TYPE_TEXT
      return (self.data_text.blank?)?   false: true 
    elsif   self.visual_widget.widget_type==VisualWidget::WIDGET_TYPE_CODE
      return (self.data_text.blank?)?   false: true 
    elsif   self.visual_widget.widget_type==VisualWidget::WIDGET_TYPE_LINK
      return (self.data_url.blank?)?    false: true 
    elsif   self.visual_widget.widget_type==VisualWidget::WIDGET_TYPE_PHOTO
      return (self.photos.blank?)?      false: true 
    elsif   self.visual_widget.widget_type==VisualWidget::WIDGET_TYPE_PHOTOS
      return (self.photos.blank?)?      false: true 
    end
    return false
  end
end
