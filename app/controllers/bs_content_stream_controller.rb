# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

class BsContentStreamController < BsAbsContentBagController
  before_action :authenticate_user!
  before_action :session_operation
  
  skip_before_action :verify_authenticity_token ,:only=>[:create_photo]

  layout  "fuga"

protected
  def session_operation
    @shop         = current_user.shop
    @content_type = ContentBag::TYPE_STREAM

    @bag_title = @shop.content_categories.find_by_category_type(@content_type).title
    
    @page         = params[:page]
    @bag          = (params[:hash_bag].blank?)? nil: ContentBag.find_by_hash_key(params[:hash_bag]) 
  end
end
