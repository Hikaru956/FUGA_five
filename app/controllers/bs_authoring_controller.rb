# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

class BsAuthoringController < ApplicationController
  before_action :authenticate_user!
  before_action :session_operation
  before_action :config_x_xss_protection

  skip_before_action :verify_authenticity_token ,:only=>[:create_widget_bag_photo]

  def index
    ###
    ##  First, Confirm "Visual Widget Bags" for this editing layout.
    #
    LayoutScheme.verify_visual_widget(@website.wsite_layout_edit, @website)

    default_navi_item = @website.default_navigation_item
    unless default_navi_item.blank? || default_navi_item.web_page.blank?
      redirect_to :controller=>'bs_authoring', :action=>default_navi_item.web_page.action_name, :hash=>Time.now.to_i, :id=>default_navi_item.web_page.content_category.id
    else
      redirect_to "/404.html"
    end
  end
  
  ###
  ##  Home
  #  
  def home;           render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.authoring_layout}/home": "#{@website.layout_pc_specific_basename}/home"); end
  ###
  ##  News
  #  
  def news_index;     @seed = @website.content_categories.find_by_id(params[:id]);  render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.authoring_layout}/news_index": "#{@website.layout_pc_specific_basename}/news_index"); end
  def news_list;      @seed = @website.content_categories.find_by_id(params[:id]);  render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.authoring_layout}/news_list":  "#{@website.layout_pc_specific_basename}/news_list");  end
  def news_show;      @seed = @website.content_leafs.find_by_id(params[:id]);       render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.authoring_layout}/news_show":  "#{@website.layout_pc_specific_basename}/news_show");  end
  ###
  ##  Blog
  #  
  def stream_index;   @seed = @website.content_categories.find_by_id(params[:id]);  render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.authoring_layout}/stream_index": "#{@website.layout_pc_specific_basename}/stream_index"); end
  def stream_list;    @seed = @website.content_categories.find_by_id(params[:id]);  render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.authoring_layout}/stream_list":  "#{@website.layout_pc_specific_basename}/stream_list");  end
  def stream_show;    @seed = @website.content_leafs.find_by_id(params[:id]);       render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.authoring_layout}/stream_show":  "#{@website.layout_pc_specific_basename}/stream_show");  end
  ###
  ##  Gallery
  #  
  def gallery_index;  @seed = @website.content_categories.find_by_id(params[:id]);  render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.authoring_layout}/gallery_index":  "#{@website.layout_pc_specific_basename}/gallery_index");  end
  def gallery_list;   @seed = @website.content_categories.find_by_id(params[:id]);  render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.authoring_layout}/gallery_list":   "#{@website.layout_pc_specific_basename}/gallery_list");   end
  def gallery_show;   @seed = @website.content_leafs.find_by_id(params[:id]);       render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.authoring_layout}/gallery_show":   "#{@website.layout_pc_specific_basename}/gallery_list");   end
  ###
  ##  Portfolio
  #
  def portfolio_index;  @seed = @website.content_categories.find_by_id(params[:id]);  render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.authoring_layout}/portfolio_index":  "#{@website.layout_pc_specific_basename}/portfolio_index");  end
  def portfolio_list;   @seed = @website.content_categories.find_by_id(params[:id]);  render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.authoring_layout}/portfolio_list":   "#{@website.layout_pc_specific_basename}/portfolio_list");   end
  def portfolio_show;   @seed = @website.content_leafs.find_by_id(params[:id]);       render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.authoring_layout}/portfolio_show":   "#{@website.layout_pc_specific_basename}/portfolio_show");   end
  ###
  ##  Contact
  #  
  def contact;          @seed = @website.content_categories.find_by_id(params[:id]);    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.authoring_layout}/contact":  "#{@website.layout_pc_specific_basename}/contact");  end
  def staff
    @target_date = (params[:target_date].blank?)? Time.now.to_date: parse_date(params[:target_date])
    @target_date = (@target_date-@target_date.wday)+1
    @seed = @website.staffs.find_by_id(params[:id])
    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.authoring_layout}/staff":    "#{@website.layout_pc_specific_basename}/staff")
  end
  ###
  ## FIXED PAGE
  #
  def fix
    @seed = @website.content_leafs.find_by_id(params[:id]);
    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.authoring_layout}/fix":  "#{@website.layout_pc_specific_basename}/fix")
  end

  ###
  ##   固定ページを伴わない、指定されたViewを表示する
  # 指定したaction名のview(erb)が存在する場合、
  # params[:name]で指定されたアクション名のViewをレンダリング
  #
  def kick
    #@page_view = @website.renderer_layout+'/'+params[:name]
    #render layout: @page_view
    #@magic_id = (params[:magic_id].blank?)? nil: params[:magic_id]
    render :layout=>((is_sp?||@website.wsite_layout_pc_specific_basename.blank?)? "#{@website.authoring_layout}/#{params[:name]}":  "#{@website.layout_pc_specific_basename}/#{params[:name]}")
  end

  ###
  ##  Layout Control
  #
  def list_layout_schemes
    @items = LayoutScheme.all
    p '❌❌'*100
    unless current_user.has_permission?(User::ROLE_SUPER)
      @items = @items.where(is_public: true)
    end
    render :layout=>"layouts/fuga_assets"
  end

  def list_layout_schemes_old
    #c = Condition.new
    c.and "is_public", true unless current_user.has_permission?(User::ROLE_SUPER)
    @items = LayoutScheme.find(:all, :conditions=>c.where)
    render :layout=>"layouts/fuga_assets"
  end

  def list_color_schemes
    @items = ColorScheme.all
    unless current_user.has_permission?(User::ROLE_SUPER)
      @items = @items.where(is_public: true)
    end
    render :layout=>"layouts/fuga_assets"
  end

  def list_color_schemes_old
    #c = Condition.new
    c.and "is_public", true unless current_user.has_permission?(User::ROLE_SUPER)
    @items = ColorScheme.find(:all, :conditions=>c.where)
    render :layout=>"layouts/fuga_assets"
  end

  def layout_for_edit
    unless @website.wsite_layout_edit.blank?
      item = LayoutScheme.find_by_id(params[:id])

      @website.wsite_layout_edit    = item
      @website.wsite_layout_deploy  = item  if @website.wsite_layout_deploy.blank?
      @website.save
      redirect_to :controller=>'bs_authoring', :action=>'index'
    end
  end

  def layout_for_deploy
    if true || request.post?
      unless @website.wsite_layout_edit.blank?
        item = LayoutScheme.find_by_id(params[:id])

        @website.wsite_layout_deploy  = item
        @website.wsite_layout_edit    = item
        @website.save
        redirect_to :controller=>'bs_authoring', :action=>'index'
      end
    end
  end

  def layout_for_nil
    if true || request.post?
      unless @website.wsite_layout_edit.blank?
        @website.wsite_layout_edit    = @website.wsite_layout_deploy
        @website.save
        redirect_to :controller=>'bs_authoring', :action=>'index'
      end
    end
  end

  def color_for_edit
    if true || request.post?
      unless @website.wsite_layout_edit.blank?
        item = ColorScheme.find_by_id(params[:id])

        @website.wsite_color_edit    = item
        @website.wsite_color_deploy  = item  if @website.wsite_color_deploy.blank?
        @website.save
        redirect_to :controller=>'bs_authoring', :action=>'index'
      end
    end
  end

  def color_for_deploy
    if true || request.post?
      unless @website.wsite_color_edit.blank?
        item = ColorScheme.find_by_id(params[:id])

        @website.wsite_color_deploy  = item
        @website.wsite_color_edit    = item
        @website.save
        redirect_to :controller=>'bs_authoring', :action=>'index'
      end
    end
  end

  def color_for_nil
    if true || request.post?
      unless @website.wsite_color_edit.blank?
        @website.wsite_color_edit    = @website.wsite_color_deploy
        @website.save
        redirect_to :controller=>'bs_authoring', :action=>'index'
      end
    end
  end

  ###
  ##
  #
  def edit_layout_edit
  end

  def edit_colors_edit
  end

  def update_layout_edit
      @website.layout_edit = params[:layout_edit]
      @website.save
      redirect_to :controller=>'bs_authoring', :action=>'index'
  end

  def update_colors_edit
      @website.colors_edit = params[:colors_edit]
      @website.save
      redirect_to :controller=>'bs_authoring', :action=>'index'
  end

  def apply_layout
      unless @website.layout_edit.blank?
        @website.layout_deploy  = @website.layout_edit
        @website.layout_edit    = nil
        @website.save
        redirect_to :controller=>'bs_authoring', :action=>'index'
      end
  end


  def apply_colors
      unless @website.colors_edit.blank?
        @website.colors_deploy  = @website.colors_edit
        @website.colors_edit    = nil
        @website.save
        redirect_to :controller=>'bs_authoring', :action=>'index'
      end
  end

  ###
  ##  Visual Widget Management
  #
  def manage_widget
    @layout = (@website.wsite_layout_edit.blank?)? @website.wsite_layout_deploy: @website.wsite_layout_edit
    render :layout=>"layouts/fuga_assets"
  end

  def update_widget_bag
      @widget_bag = VisualWidgetBag.find_by_id(params[:id])
      @widget_bag.update_attributes(widget_bag_params)
      redirect_to :action=>'manage_widget'
  end

  def new_widget_bag_photo
    @widget_bag = VisualWidgetBag.find_by_id(params[:id])
    render :layout=>"layouts/fuga_assets"
  end
  
  def create_widget_bag_photo
    @widget_bag = VisualWidgetBag.find_by_id(params[:id])
    #@photo = { :image_temp=>"", :image=>params[:file] }
    photo = Photo.new(photo_params)
    photo.shop = @website
    @widget_bag.photos << photo
    redirect_to :action=>"manage_widget"
  end

  def widget_bag_photo_higher
    photo = @shop.photos.find(params[:id])
    photo.move_higher
    photo.save
    redirect_to :action=>'manage_widget', :hash=>Time.now.to_i
  end

  def widget_bag_photo_lower
    photo = @shop.photos.find(params[:id])
    photo.move_lower
    photo.save
    redirect_to :action=>'manage_widget', :hash=>Time.now.to_i
  end

  def delete_widget_bag_photo
    photo = @shop.photos.find(params[:id])
    photo.destroy
    redirect_to :action=>'manage_widget', :hash=>Time.now.to_i
  end
  
  private
  def config_x_xss_protection
    response.headers['X-XSS-Protection'] = '0'    
  end

  def session_operation
    session[:wkey]  = params[:wkey] unless params[:wkey].blank?
    @website  = Shop.find_by_wsite_hash_key(session[:wkey])  unless session[:wkey].blank?
    @shop = @website
    @author_mode      = true
    redirect_to :action=>'/'  if @website.blank? || @website.wsite_run_mode==Shop::WSITE_BLOCKED
  end

  def photo_params
    params.require(:photo).permit(:clip)
    #params.permit(:file)
  end

  def widget_bag_params
    params.require(:widget_bag).permit(:id, :shop_id, :visual_widget_id, :data_string, :data_text, :data_url, :data_boolean, :data_code, :created_at, :updated_at)
  end

end
