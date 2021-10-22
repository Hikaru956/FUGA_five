# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

class BsContentPortfolioController < BsAbsContentBagController
  before_action :authenticate_user!
  before_action :session_operation
  
  skip_before_action :verify_authenticity_token ,:only=>[:create_photo, :create_face_photo]

  layout  "fuga"
  
  def content_category
    @parent_category = @shop.content_categories.find_by_id(params[:id])    
    @items = @parent_category.children

    c = Condition.new
    c.and "content_leafs.content_category_id", @parent_category.id
    c.and "1=1", "1=1"
#    @leafs = @shop.content_leafs.paginate(:page => params[:page], :per_page=>PER_PAGE, :conditions=>c.where, :order=>"content_leafs.position asc")
    @leafs = @shop.content_leafs.find(:all, :conditions=>c.where, :order=>"content_leafs.position asc")
  end

protected
  def session_operation
    @shop         = @current_user.shop
    @content_type = ContentBag::TYPE_PORTFOLIO

    @bag_title = @shop.content_categories.find_by_category_type(@content_type).title
    
    @page         = params[:page]
    @bag          = (params[:hash_bag].blank?)? nil: ContentBag.find_by_hash_key(params[:hash_bag]) 
  end
end
