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
#require 'file_column'
class Photo < ApplicationRecord
  acts_as_list :scope=>  [:ref_id, :ref_type]

  belongs_to  :shop
  belongs_to  :ref, polymorphic: true
  validates :clip, :attachment_presence => true


  has_attached_file :clip,
                    styles: { large: "4096x4096>", thumb: "320x240>", panel: "640x480" },
                    url: "/photo/image/0000/:id/:style/:filename",
                    path: "#{Rails.root}/public/photo/image/0000/:id/:style/:filename"
  validates_attachment_content_type :clip, content_type: /\Aimage\/.*\z/
  #hikaru
  #file_column :image, :magick => { # :size => "800>",
  #  :versions => {
  #                :thumb => {:size => "320x240>"},
  #                :panel => {:size => "640x480>"},
  #                :large => "4096x4096>" },
  #  :image_required => true }

  #validates_presence_of     :image
  #validates_filesize_of     :image, :in => 0..10.megabytes, :too_large_message => "ファイルサイズが大きすぎます(最大10MB)"
  #validates_file_format_of  :image, :in => ["gif", "png", "jpg", "jpeg", "ico"], :message => "のファイル形式は gif, png, jpg だけです。"

  #attr_accessible :image_temp, :image, :info
  
  before_create :before_create
  after_create  :after_create
  
  def before_create
    #hikaru
    #original = Magick::Image.read(self.image).first
    # puts "#-"*30
    # puts original.orientation
    # puts "#-"*30
  end
  
  
  def after_create
    #hikaru
    #my_file = File::stat(self.image)
    #self.my_size = my_file.size
    #self.save
  end

end
