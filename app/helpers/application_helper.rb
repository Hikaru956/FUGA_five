# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#
module ApplicationHelper
  require 'holiday_japan'


  def is_sp?
    return true if(/android.+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|ad|od)|iris|kindle|lge |maemo|midp|mmp|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.match(request.user_agent) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|e\-|e\/|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|xda(\-|2|g)|yas\-|your|zeto|zte\-/i.match(request.user_agent[0..3]))
    false 
  end
  

    def is_holiday?(target_date); HolidayJapan.check(target_date); end
    def holiday_title(target_date); (HolidayJapan.check(target_date))? HolidayJapan.name(target_date): ''; end
    def is_weekend?(target_date); target_date.wday==0; end

    def flag_icon(title='祝日'); sprintf("<i class='fas fa-flag fa-fw' title=%s></i>", title).html_safe; end
    def history_icon(title='内訳'); sprintf("<i class='fas fa-history fa-fw' title=%s></i>", title).html_safe; end

  require 'jcode'
  def to_sb(string)
    string.tr('０-９','0-9').tr('－', '-').tr('ー', '-').tr('＿', '_').tr('．', '.').tr('、', ',').tr(',', ',').tr('。', '.')
  end

  def parse_date(str_date)
    begin
      ret = Time.parse(str_date)
#    rescue
#      ret = Time.now
    end
    ret.strftime("%Y-%m-%d").to_date
  end

  def key_photo(model)
    return nil if model.blank?
    (model.photos.blank?)? nil: model.photos.first   
  end

  def photo_array(photos)
    array = Array.new
    photos.each do |photo|
#      if photo.image.blank?
#        file_name = photo.clip_file_name
#      else
#        file_name = photo.clip_file_name
#      end
      file_name = photo.clip_file_name
      array << "{title: '"+ file_name + "',value: '" + photo.clip.url + "'}"
      #array << "{title: '" + File::basename(photo.image) + "',value: '" + url_for_file_column(photo, :image) + "'}"
    end
    return array.map{|a| a.to_s}.join(',')    
  end

  def wday(date)
    return '' if date.blank?
    wd = %w(日 月 火 水 木 金 土)
    return wd[date.wday]
  end
  
  def publish_label(leaf)
    return nil if leaf.blank?
    unless leaf.publish_from.blank?
      raw(leaf.publish_from.strftime("%Y-%m-%d")+"&nbsp;"+"("+ wday(leaf.publish_from)+")")
    else 
      raw(leaf.created_at.strftime("%Y-%m-%d")+"&nbsp;"+"("+ wday(leaf.created_at)+")")
    end
  end

  def category_title(category)
    return model_name(category.shop)  if category.category_type==ContentCategory::TYPE_SHOP_ROOT
    return ((category.title.blank?)? "ニュース": category.title)      if category.category_type==ContentCategory::TYPE_NEWS
    return ((category.title.blank?)? "ブログ": category.title)       if category.category_type==ContentCategory::TYPE_STREAM
    return ((category.title.blank?)? "ギャラリー": category.title)   if category.category_type==ContentCategory::TYPE_GALLERY
    return ((category.title.blank?)? "価格表": category.title)       if category.category_type==ContentCategory::TYPE_PORTFOLIO
    return ((category.title.blank?)? "その他": category.title)       if category.category_type==ContentCategory::TYPE_ANONYMOUS
    return (category.web_page.blank?)?  "UNDEF":  model_name(category.web_page)
  end

  def model_name(model)
    (model.name.blank?)? "未設定" : model.name
  end
  
  def model_title(model)
    (model.title.blank?)? "未設定" : model.title
  end
  
  def model_alt_id(model)
    (model.alt_id.blank?)? "未設定" : model.alt_id
  end
  
  def logout_icon(title='ログアウト');    sprintf("<i class='icon-off' title=%s></i>", title).html_safe; end


  def icon_site_status(site_status)
    return raw("<i class='icon-spinner icon-spin'></i>")  if site_status == Shop::WSITE_PUBLISHED    
    return raw("<i class='icon-beaker'></i>")             if site_status == Shop::WSITE_TRIAL
    return raw("<i class='icon-remove'></i>")             if site_status == Shop::WSITE_BLOCKED    
  end

  def label_site_status(site_status)
    return raw "運用中"    if site_status == Shop::WSITE_PUBLISHED    
    return raw "試用中"    if site_status == Shop::WSITE_TRIAL
    return raw "停止中"    if site_status == Shop::WSITE_BLOCKED    
  end

  def icon_staff_status(staff_status)
    return raw "<i class='icon-star'></i>"        if staff_status == Staff::STAFF_PROPER    
    return raw "<i class='icon-star-half'></i>"   if staff_status == Staff::STAFF_HELPER
    return raw "<i class='icon-lock'></i>"        if staff_status == Staff::STAFF_BLOCKED    
  end

  def label_staff_status(staff_status)
    return raw "プロパー"   if staff_status == Staff::STAFF_PROPER    
    return raw "ヘルパー"   if staff_status == Staff::STAFF_HELPER
    return raw "ブロック"   if staff_status == Staff::STAFF_BLOCKED    
  end
  
  def label_user_role(user_role)
    return "スーパーユーザー"   if user_role == User::ROLE_SUPER    
    return "オペレーター"       if user_role == User::ROLE_OPERATOR    
    return "営業担当"         if user_role == User::ROLE_SALES    
    return "レジストラ"        if user_role == User::ROLE_REGISTRAR
    return "オーナー"         if user_role == User::ROLE_OWNER
    return "店舗管理者"        if user_role == User::ROLE_MANAGER    
    return "ブロガー"         if user_role == User::ROLE_BLOGGER    
    return "ブロックユーザー"     if user_role == User::ROLE_BLOCKED    
  end
  
  def bag_state_icons(bag)
    return raw '<span class="label label-info">公開中</span>' if bag.is_public
    return raw '<span class="label">非公開</span>'
  end
  
  def category_state_icons(category)
    cal = <<EOF
      <span class="label">非公開</span>
      <span class="label label-info">公開中</span>
EOF
  end

  def leaf_state_icons(leaf)
    return raw '<span class="label">非公開</span>' unless leaf.is_public
    today = Time.now.to_date
    return raw '<span class="label label-inverse">公開終了</span>'  if !leaf.publish_until.blank? && leaf.publish_until<today
    return raw '<span class="label label-warning">公開待ち</span>'  if !leaf.publish_from.blank? && today < leaf.publish_from
    return raw '<span class="label label-info">公開中</span>'
  end
  
  def scheme_state_icons(leaf)
    return raw '<span class="label">非公開</span>' unless leaf.is_public
    return raw '<span class="label label-info">公開中</span>'
  end
  
  def widget_type_string(type)
    return "文字列"    if type==VisualWidget::WIDGET_TYPE_STRING    
    return "テキスト"   if type==VisualWidget::WIDGET_TYPE_TEXT    
    return "コード"      if type==VisualWidget::WIDGET_TYPE_CODE    
    return "リンク"      if type==VisualWidget::WIDGET_TYPE_LINK    
    return "写真"        if type==VisualWidget::WIDGET_TYPE_PHOTO    
    return "複数の写真"    if type==VisualWidget::WIDGET_TYPE_PHOTOS    
  end
  
  def tree_select(categories, model, name, selected=0, level=0, init=true)
    html = ""
    # The "Root" option is added
    # so the user can choose a parent_id of 0
    if init
        # Add "Root" to the options
        html << "<select name=\"#{model}[#{name}]\" id=\"#{model}_#{name}\">\n"
#        html << "\t<option value=\"0\""
#        html << " selected=\"selected\"" if selected.parent_id == 0
#        html << ">Root</option>\n"
    end

    if categories.length > 0
      level += 1 # keep position
      
      indent = "- " * (level-1)
      
      categories.collect do |cat|
        html << "\t<option value=\"#{cat.id}\" "
        unless selected.blank?
          html << ' selected="selected"' if cat.id == selected
        end
        html << ">#{ h(indent)+cat.name}</option>\n"
        html << tree_select(cat.children, model, name, selected, level, false)
      end
    end
    html << "</select>\n" if init
    return raw html
  end

  def tree_select_tag(categories, name, selected=0, level=0, init=true)
    html = ""
    # The "Root" option is added
    # so the user can choose a parent_id of 0
    if init
        # Add "Root" to the options
        html << "<select name=\"#{name}\" id=\"#{name}\">\n"
    end

    if categories.length > 0
      level += 1 # keep position
      
      indent = "- " * (level-1)
      
      categories.collect do |cat|
        html << "\t<option value=\"#{cat.id}\" "
        unless selected.blank?
          html << ' selected="selected"' if cat.id == selected.to_i
        end
        html << ">#{ h(indent)+cat.name}</option>\n"
        html << tree_select_tag(cat.children, name, selected, level, false)
      end
    end
    html << "</select>\n" if init
    return raw html
  end

  def commify(numeric_str)
    int, frac = *numeric_str.split(".")
    int = int.gsub(/(\d)(?=\d{3}+$)/, '\\1,')
#    int = int.sub!(/^([-+]?\d+)(\d{3})/, '\1,\2')
    int << "." << frac if frac
    return int
  end
end
