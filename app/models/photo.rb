# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

#hikaru#class Photo < ActiveRecord::Base
class Photo < ApplicationRecord
  acts_as_list :scope=>  [:ref_id, :ref_type]

  belongs_to  :shop
  belongs_to  :ref, :polymorphic => true

  file_column :image, :magick => { # :size => "800>",
    :versions => {
#                  :thumb => "320x240>",
#                  :panel => "640x480>",
#                  :large => "2412x2412>" },
                  :thumb => {:size => "320x240>"},
                  :panel => {:size => "640x480>"},
                  :large => "4096x4096>" },
    :image_required => true }

  validates_presence_of     :image
  validates_filesize_of     :image, :in => 0..10.megabytes, :too_large_message => "ファイルサイズが大きすぎます(最大10MB)"
  validates_file_format_of  :image, :in => ["gif", "png", "jpg", "jpeg", "ico"], :message => "のファイル形式は gif, png, jpg だけです。"

  #attr_accessible :image_temp, :image, :info
  
  before_create :before_create
  after_create  :after_create
  
  def before_create
    original = Magick::Image.read(self.image).first
    # puts "#-"*30
    # puts original.orientation
    # puts "#-"*30
  end
  
  
  def after_create
    my_file = File::stat(self.image)
    self.my_size = my_file.size
    self.save
  end

end
