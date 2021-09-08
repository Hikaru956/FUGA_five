# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

class BsConfigController < ApplicationController
  before_action :authenticate_user!
  before_filter :session_operation

  skip_before_filter :verify_authenticity_token ,:only=>[:create_staff_photo, :create_page_photo]


  layout  "fuga"

  def index
    redirect_to :action=>'company_show_shop'
  end

  def company_show_shop
    render :layout=>'fuga_map'    
  end

  def company_edit_shop
  end

  def company_update_shop
    if request.post?
      @item = Shop.find(params[:id])
      @item.update_attributes(params[:shop])
      redirect_to :action=>"company_show_shop"
    end
  end

  def shop_edit_position
    render :layout=>"fuga_map"
  end
  
  def shop_update_position
    if request.post?
      @shop.lat = params[:lat]
      @shop.lng = params[:lng]
      @shop.save
      redirect_to :action=>"company_show_shop"
    end
  end

  def shop_delete_position
    if request.post?
      @shop.lat = nil
      @shop.lng = nil
      @shop.save
      redirect_to :action=>"company_show_shop"
    end
  end

  ###
  ##  Shop Staffs
  #
  def shop_list_staffs
    @staffs = @shop.staffs
  end

  def shop_create_staff
    if request.post?
      staff = Staff.new(params[:staff])
      staff.shop = @shop
      staff.save
      redirect_to :action=>"shop_show_staff", :id=>staff
    end
  end

  def shop_show_staff
    @staff = @shop.staffs.find(params[:id])
  end

  def shop_edit_staff
    @staff = @shop.staffs.find(params[:id])
  end

  def shop_staff_update
    if request.post?
      @item = @shop.staffs.find(params[:id])
      @item.update_attributes(params[:staff])
      redirect_to :action=>"shop_show_staff", :id=>@item
    end
  end

  def shop_staff_delete
    if request.post?
      item = @shop.staffs.find(params[:id])
      item.destroy
      redirect_to :action=>"shop_list_staffs", :id=>item.shop
    end
  end

  def staff_higher
    staff = @shop.staffs.find(params[:id])
    staff.move_higher
    staff.save
    
    @staffs = @shop.staffs
    render :action=>'shop_list_staffs'
  end

  def staff_lower
    staff = @shop.staffs.find(params[:id])
    staff.move_lower
    staff.save
    
    @staffs = @shop.staffs
    render :action=>'shop_list_staffs'
  end

  ###
  ##  Actions For Photos
  #
  def new_staff_photo
    @item = @shop.staffs.find_by_id(params[:id])    
  end

  def create_staff_photo
    if request.post?
      @item = @shop.staffs.find_by_id(params[:id]) 
      @photo = { :image_temp=>"", :image=>params[:file] }
      photo = Photo.new(@photo)
      photo.shop = @shop
      @item.photos << photo
      redirect_to :action=>"shop_show_staff", :id=>@item
    end
  end

  def photo_staff_higher
    photo = @shop.photos.find(params[:id])
    unless photo.blank?
      photo.move_higher
      photo.save
    end 
    redirect_to :action=>'shop_show_staff', :id=>photo.ref_id, :hash=>Time.now.to_i
  end

  def photo_staff_lower
    photo = @shop.photos.find(params[:id])
    unless photo.blank?
      photo.move_lower
      photo.save
    end 
    redirect_to :action=>'shop_show_staff', :id=>photo.ref_id, :hash=>Time.now.to_i
  end

  def update_staff_photo
    if request.post?
      photo = @shop.photos.find(params[:id])
      photo.update_attributes(params[:photo])
      redirect_to :action=>'shop_show_staff', :id=>photo.ref_id, :hash=>Time.now.to_i
    end
  end
  
  def delete_staff_photo
    if request.post?
      photo = @shop.photos.find(params[:id])
      photo.destroy
      redirect_to :action=>'shop_show_staff', :id=>photo.ref_id, :hash=>Time.now.to_i
    end
  end

  ###
  ##  Controllers For Shop Users
  #
  def shop_list_users
    @users = @shop.users.find(:all, :conditions=>["users.role<=?", User::ROLE_OWNER])
  end

  def shop_create_user
    if request.post?
      user = User.new(params[:user])
      user.company  = @shop.company
      user.shop     = @shop
      user.save
      redirect_to :action=>"shop_list_users"
    end
  end

  def shop_show_user
    @user = User.find(params[:id])
  end

  def shop_user_update
    if request.post?
      @item = User.find(params[:id])
      if @item.update_attributes(params[:user])
        @item.try_count = 0
        @item.save!
      end
      redirect_to :action=>"shop_show_user", :id=>@item
    end
  end

  def shop_user_delete
    if request.post?
      item = User.find(params[:id])
      item.destroy
      redirect_to :action=>"shop_list_users"
    end
  end

  def account_show
    @user = current_user
  end

  def account_update
    if request.post?
      @item = current_user
      @item.update_attributes(params[:user])
      redirect_to :action=>"account_show"
    end
  end



  ###
  ##  Controllers For WebSite Properties
  #
  def shop_show_website
  end

  def shop_update_website
    if request.post?
      @shop.update_attributes(params[:shop])
      redirect_to :action=>"shop_show_website"
    end
  end
  
  ###
  ##  Controllers For Naigation
  #
  def shop_site_navigation
    @items = WebPage.get_root_node(@shop).children
    return
    
#    root = @shop.content_categories.find_by_category_type(ContentCategory::TYPE_SHOP_ROOT)
#    @items = root.children
  end
  
  def navigation_update
    if request.post?
      @item = @shop.web_pages.find_by_id(params[:id])
      @item.update_attributes(params[:item])
      unless @item.content_category.blank?
        @item.content_category.title = @item.name
        @item.content_category.save!
      end
      redirect_to :action=>'shop_site_navigation'
    end
  end
  
  def web_page_higher
    web_page = @shop.web_pages.find_by_id(params[:id])
    web_page.move_higher
    web_page.save!
    unless web_page.content_category.blank?
      web_page.content_category.move_higher
      web_page.content_category.save!
    end
    redirect_to :action=>'shop_site_navigation'
  end

  def web_page_lower
    web_page = @shop.web_pages.find_by_id(params[:id])
    web_page.move_lower
    web_page.save!
    unless web_page.content_category.blank?
      web_page.content_category.move_lower
      web_page.content_category.save!
    end
    redirect_to :action=>'shop_site_navigation'
  end
  
  def make_public
    web_page = @shop.web_pages.find_by_id(params[:id])
    web_page.is_public = true
    web_page.save!
    unless web_page.content_category.blank?
      web_page.content_category.is_public = true
      web_page.content_category.save!
    end
    redirect_to :action=>'shop_site_navigation'
  end
  
  def make_private
    web_page = @shop.web_pages.find(params[:id])
    web_page.is_public = false
    web_page.save!
    unless web_page.content_category.blank?
      web_page.content_category.is_public = false
      web_page.content_category.save!
    end
    redirect_to :action=>'shop_site_navigation'
  end
  
  def shop_create_fixed_link
    if request.post?
      fixed_link = WebPage.new(params[:item])
      fixed_link.shop       = @shop
      fixed_link.parent     = WebPage.get_root_node(@shop)
      fixed_link.page_type  = WebPage::TYPE_LINK
      fixed_link.save
      redirect_to :action=>'shop_site_navigation'
    end
  end
  
  def shop_create_fixed_page
    if request.post?
      
      content_bag = ContentBag.retrieve_fixed_page_bag(@shop)      
#      puts "#"*12+content_bag.id.to_s

      fixed_page = WebPage.new(params[:item])

      # Allocate Leaf, first
      fixed_leaf = ContentLeaf.new
      fixed_leaf.shop = @shop
      fixed_leaf.title=fixed_page.name
      fixed_leaf.content_bag=content_bag
      fixed_leaf.is_public=true
      fixed_leaf.save
      
      # Fix up WebPage
      fixed_page.shop         = @shop
      fixed_page.name         = nil
      fixed_page.content_type = WebPage::TYPE_ANONYMOUS
      fixed_page.page_type    = WebPage::TYPE_FIX
      fixed_page.is_public    = false
      fixed_page.parent       = WebPage.get_root_node(@shop)
      fixed_page.content_key  = fixed_leaf.hash_key
      fixed_page.action_name  = 'fix'
      fixed_page.save

      redirect_to :action=>'shop_site_navigation'
    end
  end
  
  def edit_fix_page
    @item = ContentLeaf.find_by_id(params[:id])    
  end

  def update_fix_page
    if request.post?
      @item = ContentLeaf.find_by_id(params[:id])    
      @item.update_attributes(params[:item])
      redirect_to :action=>'shop_site_navigation'
    end
  end

  def shop_delete_fixed_link
    if request.post?
      web_page = @shop.web_pages.find_by_id(params[:id])
      if !web_page.blank?
        if web_page.content_type==ContentBag::TYPE_ANONYMOUS
          leaf = ContentLeaf.find_by_hash_key(web_page.content_key)          
          leaf.destroy  unless leaf.blank?
        end
        web_page.destroy
      end 
      redirect_to :action=>'shop_site_navigation'
    end
  end
  
  def list_page_photo
    @item = ContentLeaf.find_by_id(params[:id])    
  end
  
  def new_page_photo
    @item = ContentLeaf.find_by_id(params[:id])    
  end

  def create_page_photo
    if request.post?
      @item = ContentLeaf.find_by_id(params[:id])    
      @photo = { :image_temp=>"", :image=>params[:file] }
      photo = Photo.new(@photo)
      photo.shop = @shop
      @item.photos << photo
      redirect_to :action=>"list_page_photo", :id=>@item
    end
  end

  def delete_page_photo
    if request.post?
      photo = @shop.photos.find(params[:id])
      photo.destroy
      redirect_to :action=>'list_page_photo', :id=>photo.ref_id
    end
  end

protected
  def session_operation
    @shop = current_user.shop
  end
end
