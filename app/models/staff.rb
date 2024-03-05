# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

#hikaru#class Staff < ActiveRecord::Base
class Staff < ApplicationRecord
  acts_as_list  :scope => :shop

  belongs_to    :shop
  
  #hikaru
  has_many      :attendances, ->{order('attendances.attend_on ASC')},   :dependent=>:destroy 
  has_many      :reservations, ->{order('reservations.reserved_on ASC')},  :dependent=>:destroy
  #has_many      :content_leafs, ->{order('content_leafs.created_at DESC')}, :dependent=>:destroy
  has_many      :content_leafs, ->{order('content_leafs.created_at DESC')}, :dependent=>:nullify

  has_many      :photos, ->{order('photos.position ASC')},  as: :ref, :dependent => :destroy

  has_many      :calendar_marks, dependent: :destroy
  
  accepts_nested_attributes_for :photos

  STAFF_PROPER    = 100
  STAFF_HELPER    = 10
  STAFF_BLOCKED   = -1

  #attr_accessible :name, :job_title, :staff_status, :description, :social_facebook_uri, :social_gplus_uri, :social_twitter_uri, :social_pinterest_uri, :social_tumblr_uri, :social_instagram_uri

end
