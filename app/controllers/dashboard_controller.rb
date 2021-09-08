# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

class DashboardController < ApplicationController
  before_filter :check_super_privilege #hikaru :login_required,
  skip_before_filter :verify_authenticity_token ,:only=>[:create_color_photo, :create_layout_photo, :shop_create_favicon, :shop_create_apple_touch_icon]

  layout  "fuga"

  def index
    return redirect_to :action=>"company_index"
  end
  
  def delegating
#    if request.post?
      current_user.shop = Shop.find(params[:id])
      current_user.save
      redirect_to :controller=>'bs', :action=>'index'
#    end
  end
  
  def roll_back
#    if request.post?
      current_user.shop = nil
      current_user.save
      target_shop = Shop.find_by_id(params[:id])
      (target_shop.blank?)? redirect_to(:action=>'index'): redirect_to(:action=>'company_show_shop', :id=>target_shop)
#    end
  end
  
  ###
  ##  Controllers For Company
  #
  def company_index
    @items =Company.paginate(:page => params[:page], :order=>"alt_id asc", :per_page=>PER_PAGE)    
  end

  def company_create
    if request.post?
      company = Company.new(params[:item])
      company.save
      redirect_to :action=>"company_show", :id=>company
    end
  end

  def company_show
    @item = Company.find(params[:id])
  end

  def company_update
    if request.post?
      @item = Company.find(params[:id])
      @item.update_attributes(params[:item])
      redirect_to :action=>"company_show", :id=>@item
    end
  end

  def company_delete
    if request.post?
      item = Company.find(params[:id])
      item.destroy
      redirect_to :action=>"company_index"
    end
  end

  ###
  ##  Controllers For Comapny's User
  #
  def company_list_user
    @item = Company.find(params[:id])    
    @users = @item.users.find(:all, :conditions=>["role=?",User::ROLE_OWNER])
  end

  def company_create_user
    if request.post?
      company = Company.find(params[:company_id])
      user = User.new(params[:user])
      user.company = company
      user.save
      redirect_to :action=>"company_list_user", :id=>company
    end
  end

  def company_show_user
    @user = User.find(params[:id])
  end

  def company_user_update
    if request.post?
      @item = User.find(params[:id])
      if @item.update_attributes(params[:user])
        @item.try_count=0
        @item.save!
      end
      redirect_to :action=>"company_show_user", :id=>@item
    end
  end

  def company_user_delete
    if request.post?
      item = User.find(params[:id])
      item.destroy
      redirect_to :action=>"company_list_user", :id=>item.company
    end
  end

  ###
  ##  Controllers For Shop
  #
  def company_list_shop
    @item = Company.find(params[:id])
  end

  def company_create_shop
    if request.post?
      company = Company.find(params[:company_id])
      shop = Shop.new(params[:shop])
      shop.company = company
      shop.save
      redirect_to :action=>"company_show_shop", :id=>shop
    end
  end

  def company_show_shop
    @shop = @item = Shop.find(params[:id])
    render :layout=>"fuga_map"
  end

  def company_update_shop
    if request.post?
      @item = Shop.find(params[:id])
      @item.update_attributes(params[:shop])
      redirect_to :action=>"company_show_shop", :id=>@item
    end
  end

  def company_update_shop_room
    if request.post?
      @item = Shop.find(params[:id])
      @item.update_attributes(params[:shop])
      redirect_to :action=>"company_show_shop_usage", :id=>@item
    end
  end

  def company_show_shop_usage
    @shop = @item = Shop.find(params[:id])
  end

  def company_delete_shop
    if request.post?
      item = Shop.find(params[:id])
      item.destroy
      redirect_to :action=>"company_list_shop", :id=>item.company
    end
  end

  def shop_edit_position
    @item = Shop.find(params[:id])
    render :layout=>"fuga_map"
  end
  
  def shop_update_position
    if request.post?
      @item = Shop.find(params[:id])
      @item.lat = params[:lat]
      @item.lng = params[:lng]
      @item.save
      redirect_to :action=>"company_show_shop", :id=>@item
    end
  end

  def shop_delete_position
    if request.post?
      @item = Shop.find(params[:id])
      @item.lat = nil
      @item.lng = nil
      @item.save
      redirect_to :action=>"company_show_shop", :id=>@item
    end
  end

  def shop_higher
    @item = Shop.find(params[:id])
    @item.move_higher
    @item.save
    redirect_to :action=>"company_list_shop", :id=>@item.company
  end

  def shop_lower
    @item = Shop.find(params[:id])
    @item.move_lower
    @item.save
    redirect_to :action=>"company_list_shop", :id=>@item.company
  end

  ###
  ##  Controllers For Shop Staff
  #
  def shop_list_staffs
    @item = Shop.find(params[:id])
    @staffs = @item.staffs
  end

  def shop_create_staff
    if request.post?
      shop = Shop.find(params[:shop_id])
      staff = Staff.new(params[:staff])
      staff.shop = shop
      staff.save
      redirect_to :action=>"shop_show_staff", :id=>staff
    end
  end

  def shop_show_staff
    @staff = Staff.find(params[:id])
  end

  def shop_staff_update
    if request.post?
      @item = Staff.find(params[:id])
      @item.update_attributes(params[:staff])
      redirect_to :action=>"shop_show_staff", :id=>@item
    end
  end

  def shop_staff_delete
    if request.post?
      item = Staff.find(params[:id])
      item.destroy
      redirect_to :action=>"shop_list_staffs", :id=>item.shop
    end
  end

  def staff_higher
    staff = Staff.find(params[:id])
    staff.move_higher
    staff.save
    
    @item = staff.shop
    @staffs = @item.staffs
    render :action=>'shop_list_staffs'
  end

  def staff_lower
    staff = Staff.find(params[:id])
    staff.move_lower
    staff.save
    
    @item = staff.shop
    @staffs = @item.staffs
    render :action=>'shop_list_staffs'
  end


  ###
  ##  Controllers For Shop Users
  #
  def shop_list_users
    @item = Shop.find(params[:id])
    @users = @item.users
  end

  def shop_create_user
    if request.post?
      shop = Shop.find(params[:shop_id])
      user = User.new(params[:user])
      user.company  = shop.company
      user.shop     = shop
      user.save
      redirect_to :action=>"shop_list_users", :id=>shop
    end
  end

  def shop_show_user
    @user = User.find(params[:id])
  end

  def shop_user_update
    if request.post?
      @item = User.find(params[:id])
      @item.update_attributes(params[:user])
      redirect_to :action=>"shop_show_user", :id=>@item
    end
  end

  def shop_user_delete
    if request.post?
      item = User.find(params[:id])
      item.destroy
      redirect_to :action=>"shop_list_users", :id=>item.shop
    end
  end

  ###
  ##  Controllers For WebSite Properties
  #
  def shop_show_website
    @shop = Shop.find(params[:id])
  end

  def shop_update_website
    if request.post?
      @item = Shop.find(params[:id])
      @item.update_attributes(params[:shop])
      redirect_to :action=>"shop_show_website", :id=>@item
    end
  end

  def shop_new_favicon
    @shop = Shop.find(params[:id])
  end
  
  def shop_new_apple_touch_icon
    @shop = Shop.find(params[:id])
  end

  def shop_create_favicon
    if request.post?
      @shop = Shop.find(params[:id])
      ###
      ##  Clear Current Favicon
      #
      WebPage.reset_favicon(@shop)
      
      @photo = { :image_temp=>"", :image=>params[:file] }
      photo = Photo.new(@photo)
      photo.shop = @shop
      photo.ref = WebPage.get_root_node(@shop)
      photo.save!

      redirect_to :action=>"shop_show_website", :id=>@shop
    end
  end
  
  def shop_create_apple_touch_icon
    if request.post?
      @shop = Shop.find(params[:id])
      ###
      ##  Clear Current Apple Touch Icon
      #
      WebPage.reset_apple_touch_icon(@shop)
      
      @photo = { :image_temp=>"", :image=>params[:file] }
      photo = Photo.new(@photo)
      photo.shop = @shop
      photo.ref = WebPage.get_root_node(@shop)
      photo.save!

      redirect_to :action=>"shop_show_website", :id=>@shop
    end
  end
  
  def shop_reset_favicon
    if request.post?
      @shop = Shop.find(params[:id])
      WebPage.reset_favicon(@shop)
      redirect_to :action=>"shop_show_website", :id=>@shop
    end
  end
  
  def shop_reset_apple_touch_icon
    if request.post?
      @shop = Shop.find(params[:id])
      WebPage.reset_apple_touch_icon(@shop)
      redirect_to :action=>"shop_show_website", :id=>@shop
    end
  end
  
  def set_disqus_mode
    if request.post?
      @shop = Shop.find(params[:id])
      @shop.update_attributes(params[:shop])
      redirect_to :action=>"shop_show_website", :id=>@shop
    end
  end
  
  def set_disqus_code
    if request.post?
      @shop = Shop.find(params[:id])
      @shop.update_attributes(params[:shop])
      redirect_to :action=>"shop_show_website", :id=>@shop
    end
  end

  ###
  ##  Controllers For Admin. Users
  #
  def user_list
    @users = User.find(:all,:conditions=>["role>? && role<=?", User::ROLE_OWNER, current_user.role], :order=>"role desc, name asc")
  end

  def user_create
    if request.post?
      user = User.new(params[:user])
      user.save
      redirect_to :action=>"user_list"
    end
  end

  def user_show
    @user = User.find(params[:id])
  end

  def user_update
    if request.post?
      @item = User.find(params[:id])
      if @item.update_attributes(params[:user])
        @item.try_count=0
        @item.save!
      end
      redirect_to :action=>"user_show", :id=>@item
    end
  end

  def user_delete
    if request.post?
      item = User.find(params[:id])
      item.destroy
      redirect_to :action=>"user_list"
    end
  end

  ###
  ##  Controllers For ColorSchemes
  #
  def color_list
    @colors = ColorScheme.find(:all, :order=>"position asc")
  end

  def color_create
    if request.post?
      color = ColorScheme.new(params[:color])
      color.save
      redirect_to :action=>"color_show", :id=>color
    end
  end

  def color_show
    @color = ColorScheme.find(params[:id])
  end

  def color_update
    if request.post?
      @item = ColorScheme.find(params[:id])
      @item.update_attributes(params[:color])
      redirect_to :action=>"color_show", :id=>@item
    end
  end

  def color_delete
    if request.post?
      item = ColorScheme.find(params[:id])
      item.destroy
      redirect_to :action=>"color_list"
    end
  end

  def color_higher
    item = ColorScheme.find(params[:id])
    item.move_higher
    item.save
    redirect_to :action=>'color_list'
  end

  def color_lower
    item = ColorScheme.find(params[:id])
    item.move_lower
    item.save
    redirect_to :action=>'color_list'
  end

  def new_color_photo
    @item = ColorScheme.find(params[:id])
  end

  def create_color_photo
    if request.post?
      @item = ColorScheme.find(params[:id])
      @photo = { :image_temp=>"", :image=>params[:file] }
      photo = Photo.new(@photo)
      photo.shop = nil
      @item.photo = photo
      redirect_to :action=>"color_show", :id=>@item
    end
  end

  def delete_color_photo
    if request.post?
      photo = Photo.find(params[:id])
      photo.destroy
      redirect_to :action=>'color_show', :id=>photo.ref_id, :hash=>Time.now.to_i
    end
  end

  ###
  ##  Controllers For LayoutSchemes
  #
  def layout_list
    @layouts = LayoutScheme.find(:all, :order=>"position asc")
  end

  def layout_create
    if request.post?
      layout = LayoutScheme.new(params[:layout])
      layout.save
      redirect_to :action=>"layout_show", :id=>layout
    end
  end

  def layout_show
    @layout = LayoutScheme.find(params[:id])
  end

  def layout_update
    if request.post?
      @item = LayoutScheme.find(params[:id])
      @item.update_attributes(params[:layout])
      redirect_to :action=>"layout_show", :id=>@item
    end
  end

  def layout_delete
    if request.post?
      item = LayoutScheme.find(params[:id])
      item.destroy
      redirect_to :action=>"layout_list"
    end
  end

  def layout_higher
    item = LayoutScheme.find(params[:id])
    item.move_higher
    item.save
    redirect_to :action=>'layout_list'
  end

  def layout_lower
    item = LayoutScheme.find(params[:id])
    item.move_lower
    item.save
    redirect_to :action=>'layout_list'
  end

  def new_layout_photo
    @item = LayoutScheme.find(params[:id])
  end

  def create_layout_photo
    if request.post?
      @item = LayoutScheme.find(params[:id])
      @photo = { :image_temp=>"", :image=>params[:file] }
      photo = Photo.new(@photo)
      photo.shop = nil
      @item.photo = photo
      redirect_to :action=>"layout_show", :id=>@item
    end
  end

  def delete_layout_photo
    if request.post?
      photo = Photo.find(params[:id])
      photo.destroy
      redirect_to :action=>'layout_show', :id=>photo.ref_id, :hash=>Time.now.to_i
    end
  end

  def widget_list
    @layout = LayoutScheme.find(params[:id])
  end

  ###
  ##  Visual Widget
  #
  def widget_create
    if request.post?
      visual_widget = VisualWidget.new(params[:item])
      visual_widget.save
      redirect_to :action=>"widget_list", :id=>visual_widget.layout_scheme
    end
  end

  def widget_update
    if request.post?
      @item = VisualWidget.find(params[:id])
      @item.update_attributes(params[:item])
      redirect_to :action=>"widget_list", :id=>@item.layout_scheme
    end
  end

  def widget_delete
    if request.post?
      @item = VisualWidget.find(params[:id])
      @item.destroy
      redirect_to :action=>"widget_list", :id=>@item.layout_scheme
    end
  end

  def widget_higher
    @item = VisualWidget.find(params[:id])
    @item.move_higher
    @item.save
    redirect_to :action=>"widget_list", :id=>@item.layout_scheme
  end

  def widget_lower
    @item = VisualWidget.find(params[:id])
    @item.move_lower
    @item.save
    redirect_to :action=>"widget_list", :id=>@item.layout_scheme
  end

end
