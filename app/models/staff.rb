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
  
  has_many      :attendances,   :dependent=>:destroy,  :order=>'attend_on asc'
  has_many      :reservations,  :dependent=>:destroy,  :order=>'reserved_on asc'
  has_many      :content_leafs, :dependent=>:destroy,  :order=>'created_at desc'

  has_many      :photos,  :as => :ref, :dependent => :destroy, :order=>"position asc"

  STAFF_PROPER    = 100
  STAFF_HELPER    = 10
  STAFF_BLOCKED   = -1

  attr_accessible :name, :job_title, :staff_status, :description, :social_facebook_uri, :social_gplus_uri, :social_twitter_uri, :social_pinterest_uri, :social_tumblr_uri, :social_instagram_uri

end
