# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

class BsController < ApplicationController
  #hikaru
  before_action :authenticate_user!
  before_action :session_operation

  layout  "fuga"
  
  def index
    redirect_to :controller=>'bs_config', :action=>'company_show_shop'
  end
  
  def list_news
    if @bag.blank?
      #c = Condition.new
      #c.and "content_leafs.content_category_id", 'IN', ContentCategory.type_root(@shop, ContentCategory::TYPE_NEWS).children
      #@items = @shop.content_leafs.paginate(:page => params[:page], :per_page=>PER_PAGE, :conditions=>c.where)


      @items = @shop.content_leafs.where("content_leafs.content_category_id IN (?)", ContentCategory.type_root(@shop, ContentCategory::TYPE_NEWS).children)
      @items = @items.paginate(:page => params[:page], :per_page=>PER_PAGE)
    else
      @items = @bag.content_leafs.paginate(:page => params[:page],  :per_page=>PER_PAGE)
    end
  end
  
  def show_news
    @item = ContentLeaf.find_by_hash_key(params[:hash_leaf])
  end
  
  def create_news
    if request.post?
      @item = ContentLeaf.new(hikaru_params)
      if @item.save
        redirect_to :action=>"show_news", :hash_leaf=>@item.hash_key, :hash_bag=>(@bag.blank?)? nil: @bag.hash_key
      else
        redirect_to :action=>"list"
      end
    end
  end
  
  def update_news
    if request.post?
      @item = ContentLeaf.find_by_hash_key(params[:hash_leaf])
      @item.update_attributes(params[:item])
      redirect_to :action=>"show_news", :hash_leaf=>@item.hash_key, :hash_bag=>(@bag.blank?)? nil: @bag.hash_key
    end
  end
  
  def delete_customer
    if request.post?
      item = ContentLeaf.find_by_hash_key(params[:hash_leaf])
      item.destroy
      redirect_to :action=>"list_news", :hash_bag=>(@bag.blank?)? nil: @bag.hash_key
    end
  end
  
  
  protected
  def session_operation
    @shop = current_user.shop
    @page = params[:page]
    @bag  = (params[:hash_bag].blank?)? nil: ContentBag.find_by_hash_key(params[:hash_bag]) 
  end
end
