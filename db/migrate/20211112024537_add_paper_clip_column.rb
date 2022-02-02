class AddPaperClipColumn < ActiveRecord::Migration[5.2]
  def self.up
    change_table :photos do |t|
      t.attachment :clip
    end


    Photo.all.each do |photo|
      photo.clip_file_name = photo.image

      ext = File.extname(photo.image)
      case ext
      when '.png'
        ext = 'image/png'
      when '.jpg', '.jpeg', '.jpe', '.jfif', '.jfi'
        ext = 'image/jpeg'
      when '.gif'
        ext = 'image/gif'
      when '.ico'
        ext = 'image/x-icon'
      when '.bmp', '.rle', '.dib'
        ext = 'image/x-bmp'
      when '.tiff', '.tif'
        ext = 'image/tiff'
      else
        ext = 'image/jpeg'
      end

      photo.clip_content_type = ext
      photo.clip_file_size = photo.my_size
      photo.clip_updated_at = photo.updated_at
      photo.save!
    end
  end

  def self.down
    remove_attachment :photos, :clip
  end
end
