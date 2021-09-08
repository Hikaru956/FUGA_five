# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

class RemoteLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer
  
  def page_link_or_span(page, span_class, text = nil)
    text ||= page.to_s
    classnames = Array[*span_class]
    
    if page and page != current_page
      @template.link_to_remote text, :url=>url_for(page)
    else
      @template.content_tag :span, text, :class => classnames.join(' ')
    end
  end
end
