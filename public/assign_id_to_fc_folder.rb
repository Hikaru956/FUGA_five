#  public直下で実行
require 'fileutils'
path_getwd = Dir.getwd
puts "assign_id_to_fc_folder：#{path_getwd}"

Dir.chdir('photo/image')
path_pwd = Dir.pwd
puts "変換処理開始：#{path_pwd}"
# フォルダーを取得
Dir.glob("./*") do |f|
  next unless FileTest.directory?(f)
  segment_folder_name = File.split(f)[1]
  segment_prefix = nil
  puts "セグメント・フォルダー：#{segment_folder_name}"
  begin
      segment_prefix = Integer('0d'+segment_folder_name)
      puts "プレフィックス：#{segment_prefix}"
  rescue
      puts "スキップ #{segment_folder_name}"
      next;
  end
  FileUtils.chdir(segment_folder_name) {
    Dir.glob("./*") do |f|
      next unless FileTest.directory?(f)
      data_folder_name = File.split(f)[1]
      #puts "データ・フォルダー：#{data_folder_name}"
      segment_suffix = nil
      begin
        segment_suffix = data_folder_name
      rescue
        next
      end
      new_folder_name = (segment_prefix==0)? Integer('0d' + segment_suffix).to_s: \
                                             Integer('0d' + segment_prefix.to_s + segment_suffix.to_s).to_s
      

      org_folder_name  = f
      new_folder_name = File.split(f)[0]+'/'+new_folder_name
      #puts "元フォルダーパス : #{org_folder_name}"
      #puts "新フォルダーパス : #{new_folder_name}"
      puts "データ・フォルダー名変換： #{segment_prefix} : #{org_folder_name} -> #{new_folder_name}"
      File::rename(org_folder_name, new_folder_name)

      # データ・フォルダーに移動
      FileUtils.chdir(new_folder_name) {
        # 「original」という名称でフォルダーを作成
        Dir.mkdir("original") unless Dir.exist?("original")
        # データフォルダー内のファイルを列挙
        Dir.glob("./*") do |original_clip|
          next if FileTest.directory?(original_clip)
          #  オリジナルの画像ファイルを同盟で「original」フォルダーに移動
          FileUtils.mv(original_clip, 'original')
        end
      }

      #  データ・フォルダーを「clip」フォルダー階層に移動
      FileUtils.mv(new_folder_name, '../clip' )
    end
  }
end
