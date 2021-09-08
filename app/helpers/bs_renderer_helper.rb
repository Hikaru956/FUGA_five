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


end
