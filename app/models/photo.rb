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

  belongs_to  :shop, optional: true
  belongs_to  :ref, polymorphic: true, optional: true
  validates :clip, :attachment_presence => true


  has_attached_file :clip,
                    styles: lambda { |a| 
                      if a.respond_to?(:original_filename) && a.original_filename&.end_with?('.ico')
                        {} # .ico はリサイズしない
                      else
                        { large: "4096x4096>", thumb: "320x180>", panel: "640x480" } # .ico 以外はリサイズ
                      end
                    },
                    url: "/photo/image/clip/:id/:style/:filename",
                    path: "#{Rails.root}/public/photo/image/clip/:id/:style/:filename",
                    processors: lambda { |a| 
                      a.respond_to?(:original_filename) && a.original_filename&.end_with?('.ico') ? [] : [:thumbnail]
                    }

  validates_attachment_content_type :clip, content_type: [/\Aimage\/.*\z/, "image/x-icon", "image/jpeg", "image/gif", "image/png", "image/webp", "application/octet-stream"]

  before_validation :override_mime_type


  #has_attached_file :clip,
  #                  styles: { large: "4096x4096>", thumb: "320x180>", panel: "640x480" },
  #                  url: "/photo/image/clip/:id/:style/:filename",
  #                  path: "#{Rails.root}/public/photo/image/clip/:id/:style/:filename"
  #validates_attachment_content_type :clip, content_type: ["image/jpeg", "image/gif", "image/png", "image/webp"]




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
  
  def file_size

    fc_size = self.my_size
    fc_size = 0 if fc_size.blank?
    pc_size = self.clip_file_size 
    pc_size = 0 if pc_size.blank?
    fc_size+pc_size

  end

  def self.total_file_size(photos)
    return 0 if photos.blank?
    sum_size = 0
    photos.each do |photo|
      sum_size += photo.file_size
    end
    return sum_size
  end

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

  private

  def override_mime_type
    if clip_content_type == 'application/octet-stream' || (clip_content_type == 'image/webp' && clip_file_name =~ /\.webp\z/)
      self.clip.instance_write(:content_type, 'image/webp')
    else
      Rails.logger.debug "Content type not overridden"
    end
  end

end
