# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

class BsRendererController < ApplicationController
  #before_action :authenticate_user!, except: :home
  before_action :session_operation
  before_action :config_x_xss_protection

  def index
    default_navi_item = @website.default_navigation_item
    unless default_navi_item.blank? || default_navi_item.web_page.blank?
      redirect_to :controller=>default_navi_item.web_page.controller_name, :action=>default_navi_item.web_page.action_name, :wkey=>@website.wsite_hash_key, :hash=>Time.now.to_i
    else
      # hikaru@956.jp : KONIKONI問題
      root_child   = @website.default_root_child
      content_leaf = (root_child.blank?)? nil: ContentLeaf.find_by(hash_key: root_child.content_key)
      return redirect_to  action: 'fix', id: content_leaf.id, wkey: @website.wsite_hash_key if !content_leaf.blank? && root_child.page_type==WebPage::TYPE_FIX

      render :file=>"public/404.html", :layout=>false, :status => 404
      return
    end
  end

  ###
  ##  Home
  #  
  def home;           render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.renderer_layout}/home": "#{@website.layout_pc_specific_basename}/home"); end
  ###
  ##  News
  #  
  def news_index
    @seed = (params[:id].blank?)? ContentCategory.type_root(@website, ContentCategory::TYPE_NEWS): @website.content_categories.find_by_id(params[:id])
    if @seed.blank?
      render :file=>"public/404.html", :layout=>false, :status => 404
      return
    end
    if @seed.has_only_a_public_bag?
      redirect_to(:action=>'news_list', :id=>@seed.public_bags[0]); return
    end
    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.renderer_layout}/news_index": "#{@website.layout_pc_specific_basename}/news_index")
  end
  def news_list
    @seed = @website.content_categories.find_by_id(params[:id])
    @search_tags = params[:search_tags]
    if @seed.blank?
      render :file=>"public/404.html", :layout=>false, :status => 404
      return
    end
    @page=params[:page];
    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.renderer_layout}/news_list":  "#{@website.layout_pc_specific_basename}/news_list");
  end
  def news_show
    @seed = @website.content_leafs.find_by_id(params[:id]);
    if @seed.blank?
      render :file=>"public/404.html", :layout=>false, :status => 404
      return
    end
    @page=params[:page];
    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.renderer_layout}/news_show":  "#{@website.layout_pc_specific_basename}/news_show");  
  end
  ###
  ##  Blog
  #  
  def stream_index
    @seed = (params[:id].blank?)? ContentCategory.type_root(@website, ContentCategory::TYPE_STREAM): @website.content_categories.find_by_id(params[:id])
    if @seed.blank?
      render :file=>"public/404.html", :layout=>false, :status => 404
      return
    end
    if @seed.has_only_a_public_bag?
      redirect_to(:action=>'stream_list', :id=>@seed.public_bags[0]); return
    end
    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.renderer_layout}/stream_index": "#{@website.layout_pc_specific_basename}/stream_index"); 
  end
  def stream_list
    @seed = @website.content_categories.find_by_id(params[:id]);  
    if @seed.blank?
      render :file=>"public/404.html", :layout=>false, :status => 404
      return
    end
    @page=params[:page];  
    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.renderer_layout}/stream_list":  "#{@website.layout_pc_specific_basename}/stream_list");
  end
  def stream_show
    @seed = @website.content_leafs.find_by_id(params[:id])
    if @seed.blank?
      render :file=>"public/404.html", :layout=>false, :status => 404
      return
    end
    @page=params[:page]
    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.renderer_layout}/stream_show":  "#{@website.layout_pc_specific_basename}/stream_show")
  end
  ###
  ##  Gallery
  #  
  def gallery_index
    @seed = (params[:id].blank?)? ContentCategory.type_root(@website, ContentCategory::TYPE_GALLERY): @website.content_categories.find_by_id(params[:id])
    if @seed.blank?
      render :file=>"public/404.html", :layout=>false, :status => 404
      return
    end
    if @seed.has_only_a_public_bag?
      redirect_to(:action=>'gallery_list', :id=>@seed.public_bags[0]); return
    end
    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.renderer_layout}/gallery_index":  "#{@website.layout_pc_specific_basename}/gallery_index");  
  end
  def gallery_list
    @seed = @website.content_categories.find_by_id(params[:id]);  
    if @seed.blank?
      render :file=>"public/404.html", :layout=>false, :status => 404
      return
    end
    @page=params[:page];  
    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.renderer_layout}/gallery_list":   "#{@website.layout_pc_specific_basename}/gallery_list");   
  end
  def gallery_show
    @seed = @website.content_leafs.find_by_id(params[:id]);
    if @seed.blank?
      render :file=>"public/404.html", :layout=>false, :status => 404
      return
    end
    @page=params[:page];
    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.renderer_layout}/gallery_show":   "#{@website.layout_pc_specific_basename}/gallery_show");
  end
  ###
  ##  Portfolio
  #
  def portfolio_index
    @seed = (params[:id].blank?)? ContentCategory.type_root(@website, ContentCategory::TYPE_PORTFOLIO): @website.content_categories.find_by_id(params[:id])
    if @seed.blank?
      render :file=>"public/404.html", :layout=>false, :status => 404
      return
    end
    if @seed.has_only_a_public_bag?
      redirect_to(:action=>'portfolio_list', :id=>@seed.public_bags[0]); return
    end
    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.renderer_layout}/portfolio_index":  "#{@website.layout_pc_specific_basename}/portfolio_index");  end
  def portfolio_list
   @seed = @website.content_categories.find_by_id(params[:id])
    if @seed.blank?
      render :file=>"public/404.html", :layout=>false, :status => 404
      return
    end
   @page=params[:page];  
   render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.renderer_layout}/portfolio_list":   "#{@website.layout_pc_specific_basename}/portfolio_list");   
  end
  def portfolio_show
    @seed = @website.content_leafs.find_by_id(params[:id]);
    if @seed.blank?
      render :file=>"public/404.html", :layout=>false, :status => 404
      return
    end
    @page=params[:page];  
    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.renderer_layout}/portfolio_show":   "#{@website.layout_pc_specific_basename}/portfolio_show");   
  end
  ###
  ##  Contact
  #  
  def contact
    staffs = @website.staffs.where("staffs.staff_status !=?", Staff::STAFF_BLOCKED)
    if staffs.size == 1
      return redirect_to(:action=>'staff', :id=>staffs[0].id, :wkey=>@website.wsite_hash_key)
    else
      render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.renderer_layout}/contact":  "#{@website.layout_pc_specific_basename}/contact")
    end
  end

  def staff
    @target_date = (params[:target_date].blank?)? Time.now.to_date: parse_date(params[:target_date])
    @target_date = (@target_date-@target_date.wday)+1
    @seed = @website.staffs.find_by_id(params[:id])
    if @seed.blank?
      render :file=>"public/404.html", :layout=>false, :status => 404
      return
    end
    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.renderer_layout}/staff":    "#{@website.layout_pc_specific_basename}/staff")
  end

  def reserve
    #logger.error '❌　'+@website.renderer_layout
    render :layout=>"#{@website.renderer_layout}/reserve"
  end

  ###
  ## FIXED PAGE
  #
  def fix
    @seed = (@website.content_leafs.find_by(id: params[:id]) || @website.content_leafs.find_by(title: params[:id]));
    if @seed.blank?
      render :file=>"public/404.html", :layout=>false, :status => 404
      return
    end
    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.renderer_layout}/fix":  "#{@website.layout_pc_specific_basename}/fix")
  end

  ###
  ##   固定ページを伴わない、指定されたViewを表示する
  # 指定したaction名のview(erb)が存在する場合、
  # params[:name]で指定されたアクション名のViewをレンダリング
  #
  def kick
    @page_view = @website.renderer_layout+'/'+params[:name]
    #@magic_id = (params[:magic_id].blank?)? nil: params[:magic_id]
    render layout: @page_view
  end

  ###
  ## FEED
  #
  def news_feed
    @feed = ContentCategory.type_root(@website, ContentCategory::TYPE_NEWS)
    @posts = (@feed.blank?)? []: rss_feed_items(@feed, 50);       
    respond_to do |format|
      format.rss { render :layout => false } #news_feed.rss.builder
    end
  end

  def stream_feed
    @feed = ContentCategory.type_root(@website, ContentCategory::TYPE_STREAM)
    @posts =  (@feed.blank?)? []: rss_feed_items(@feed, 50);       
    respond_to do |format|
      format.rss { render :layout => false } #stream_feed.rss.builder
    end
  end
  ###
  ## INQUIRY
  #
  def inquiry_new
    @seed = ContentCategory.new
    @seed.title = "お問い合わせ"
    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.renderer_layout}/inquiry_new":  "#{@website.layout_pc_specific_basename}/inquiry_new")
  end

  def inquiry_create
    @seed = ContentCategory.new
    @seed.title = "お問い合わせ"
    @item = Inquiry.new(inquiry_params)
    @item.save!
    InquiryMailer.send_mail(@item).deliver_later
    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.renderer_layout}/inquiry_commited":  "#{@website.layout_pc_specific_basename}/inquiry_commited")
  end

  private
  def config_x_xss_protection
    response.headers['X-XSS-Protection'] = '0'    
  end

  def session_operation
    session[:wkey]  = params[:wkey] unless params[:wkey].blank?
    @website        = (session[:wkey].blank?)? nil: Shop.find_by_wsite_hash_key(session[:wkey])
    @author_mode = false
    if @website.blank? || @website.wsite_run_mode==Shop::WSITE_BLOCKED
      render :file=>"public/404.html", :layout=>false, :status => 404
      return
    end  
  end

  def inquiry_params
    params.require(:inquiry).permit(:id, :shop_id, :email, :name, :body, :status, :created_at, :updated_at)
  end

end
