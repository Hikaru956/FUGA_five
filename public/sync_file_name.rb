def self.up
    require "fileutils"
    photos = Photo.all
    puts photos.size
    path_wd = Dir.getwd
    puts path_wd
    photos.each do |p|
      FileUtils.cd(path_wd)
      photo_path = (path_wd+"/public/photo/image/clip/"+p.id.to_s+"/original")
      #puts photo_path
      next unless Dir.exist?(photo_path)
      FileUtils.cd(photo_path)
      #FileUtils.cd(photo_path, **{:verbose=>true})


      Dir.foreach(".") do |photo_file|

        next if photo_file == "." || photo_file == ".."
        next if photo_file == p.clip_file_name
        puts p.id.to_s+" : "+p.clip_file_name

        #conv = ActiveSupport::Multibyte::Unicode.normalize(photo_file,:c)
        
        FileUtils.mv(photo_file.to_s, p.clip_file_name+'.956')
        FileUtils.mv(p.clip_file_name+'.956', p.clip_file_name)

        if Dir.exist?(path_wd+'/public/photo/image/clip/'+p.id.to_s+'/large')
          FileUtils.cd(path_wd+'/public/photo/image/clip/'+p.id.to_s+'/large')
          if File.exist?(photo_file)
            FileUtils.mv(photo_file.to_s, p.clip_file_name+'.956')
            FileUtils.mv(p.clip_file_name+'.956', p.clip_file_name)
          end
        end
        if Dir.exist?(path_wd+'/public/photo/image/clip/'+p.id.to_s+'/panel')
          FileUtils.cd(path_wd+'/public/photo/image/clip/'+p.id.to_s+'/panel')
          if File.exist?(photo_file)
            FileUtils.mv(photo_file.to_s, p.clip_file_name+'.956')
            FileUtils.mv(p.clip_file_name+'.956', p.clip_file_name)
          end
        end
        if Dir.exist?(path_wd+'/public/photo/image/clip/'+p.id.to_s+'/thumb')
          FileUtils.cd(path_wd+'/public/photo/image/clip/'+p.id.to_s+'/thumb')
          if File.exist?(photo_file)
            FileUtils.mv(photo_file.to_s, p.clip_file_name+'.956')
            FileUtils.mv(p.clip_file_name+'.956', p.clip_file_name)
          end
        end
      end









    end
  end
  def self.down
  end
