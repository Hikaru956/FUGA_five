# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

module BsRendererHelper

  def fuga_colors_stylesheets_link(wsite, is_author_mode)
    style_sheet_uri = COLOR_ASSETS+'/'
    style_sheet_uri += (is_author_mode)?  wsite.wsite_color_edit.repository_path: wsite.wsite_color_deploy.repository_path

    stylesheet_link_tag style_sheet_uri
  end

  def copyright_notice(shop)
    raw ( (shop.copyright_notice.blank?)? 'Copyright&nbsp;&copy;&nbsp;'+Time.now.year.to_s+'&nbsp;'+model_name(shop.company): shop.copyright_notice )
  end

  def v_w(website, widget_title)
    widget = VisualWidget.find_by(title: widget_title)
    return nil if widget.blank?

    widget_bag = VisualWidget.search_widget_bag_for(website, widget.hash_key)

    return '' if widget_bag.blank?
    case widget_bag.visual_widget.widget_type
    when VisualWidget::WIDGET_TYPE_STRING
      return widget_bag.data_string
    when VisualWidget::WIDGET_TYPE_TEXT
      return widget_bag.data_text
    when VisualWidget::WIDGET_TYPE_CODE
      return raw widget_bag.data_code
    when VisualWidget::WIDGET_TYPE_LINK
      return raw widget_bag.data_url
    end
    return ''
  end


end
