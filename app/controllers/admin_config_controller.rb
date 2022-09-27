class AdminConfigController < ApplicationController
    before_action :authenticate_user!
  before_action :session_operation

  skip_before_action :verify_authenticity_token ,:only=>[:create_staff_photo, :create_page_photo]


  layout  "fuga5"

  def index
    return destroy_user_session_path if current_user.blank?
    redirect_to :action=>'company_show_shop'
  end

  def company_show_shop
  end

  def company_edit_shop
  end

  def company_update_shop
      @item = Shop.find(params[:id])
      #@item.update_attributes(params[:shop])
      @item.update(shop_params)
      redirect_to :action=>"company_show_shop"
  end

  def shop_edit_position
  end

  def shop_update_position
    @shop.lat = params[:lat]
    @shop.lng = params[:lng]
    @shop.save
    redirect_to :action=>"company_show_shop"
  end

  def shop_delete_position
    @shop.lat = nil
    @shop.lng = nil
    @shop.save
    redirect_to :action=>"company_show_shop"
  end

  ###
  ##  Shop Staffs
  #
  def shop_list_staffs
    @staffs = @shop.staffs
  end

  def shop_create_staff
    #shop = Shop.find(params[:shop_id])
    staff = Staff.new(staff_params)
    staff.shop = @shop
    staff.save
    redirect_to :action=>"shop_show_staff", :id=>staff
  end

  def shop_show_staff
    @staff = @shop.staffs.find(params[:id])
  end

  def shop_edit_staff
    @staff = @shop.staffs.find(params[:id])
  end

  def shop_update_staff
      @item = @shop.staffs.find(params[:id])
      @item.update_attributes(staff_params)
      redirect_to :action=>"shop_show_staff", :id=>@item
  end

  def shop_delete_staff
    #item = @shop.staffs.find(params[:id])
    #item.destroy
    #redirect_to :action=>"shop_list_staffs", :id=>item.shop

    item = Staff.find(params[:id])
    item.destroy
    redirect_to :action=>"shop_list_staffs", :id=>item.shop
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
  def new_shop_photo
    @item = Shop.find_by_id(params[:id])
  end

  def new_staff_photo
    @item = @shop.staffs.find_by_id(params[:id])
  end

  #def create_staff_photo
  #  @item = @shop.staffs.find_by_id(params[:id])
  #  @photo = { :image_temp=>"", :image=>params[:file] }
  #  photo = Photo.new(@photo)
  #  photo.shop = @shop
  #  @item.photos << photo
  #  redirect_to :action=>"shop_show_staff", :id=>@item
  #end

  def create_shop_photo
    photo = Photo.new(photo_params)
    photo.shop = @shop
    photo.ref = @shop
    @shop.photos << photo
    @shop.photos.build
    redirect_to :action=>"company_show_shop", :id=>@shop
  end

  def update_shop_photo
    photo = @shop.photos.find(params[:id])
    photo.update_attributes(photo_params)
    redirect_to :controller=>'admin_config', :action=>'company_show_shop', :id=>photo.ref_id, :hash=>Time.now.to_i
  end

  def delete_shop_photo
    photo = @shop.photos.find(params[:id])
    photo.destroy
    redirect_to :controller=>'admin_config', :action=>'company_show_shop', :id=>photo.ref_id, :hash=>Time.now.to_i
  end

  def photo_shop_higher
    photo = @shop.photos.find(params[:id])
    unless photo.blank?
      photo.move_higher
      photo.save
    end
    redirect_to :action=>'company_show_shop', :id=>photo.ref_id, :hash=>Time.now.to_i
  end

  def photo_shop_lower
    photo = @shop.photos.find(params[:id])
    unless photo.blank?
      photo.move_lower
      photo.save
    end
    redirect_to :action=>'company_show_shop', :id=>photo.ref_id, :hash=>Time.now.to_i
  end

  def create_staff_photo
    @item = @shop.staffs.find_by_id(params[:id])
    photo = Photo.new(photo_params)
    photo.shop = @shop
    @item.photos << photo
    @item.photos.build
    redirect_to :action=>"shop_show_staff", :id=>@item
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
    photo = @shop.photos.find(params[:id])
    photo.update_attributes(photo_params)
    redirect_to :action=>'shop_show_staff', :id=>photo.ref_id, :hash=>Time.now.to_i
  end

  def delete_staff_photo
    photo = @shop.photos.find(params[:id])
    photo.destroy
    redirect_to :action=>'shop_show_staff', :id=>photo.ref_id, :hash=>Time.now.to_i
  end

  ###
  ##  Controllers For Shop Users
  #
  def shop_list_users
    @users = @shop.users.where('role<=?',User::ROLE_OWNER)
    #@users = @shop.users.find(:all, :conditions=>["users.role<=?", User::ROLE_OWNER])
  end

  def shop_create_user
      user = User.new(user_params)
      user.company  = @shop.company
      user.shop     = @shop
      user.save
      redirect_to :action=>"shop_list_users"
  end

  def shop_show_user
    @user = User.find(params[:id])
  end

  def shop_update_user
    @item = User.find(params[:id])
    @item.update_attributes(user_params)
    @item.try_count = 0
    @item.save!
    redirect_to :action=>"shop_show_user", :id=>@item
  end

  def shop_delete_user
      item = User.find(params[:id])
      item.destroy
      redirect_to :action=>"shop_list_users"
  end

  def account_show
    @user = current_user
  end

  def account_update
    @item = current_user
    @item.update_attributes(params[:user])
    redirect_to :action=>"account_show"
  end



  ###
  ##  Controllers For WebSite Properties
  #
  def shop_show_website
  end

  def shop_update_website
      @shop.update_attributes(shop_params)
      redirect_to :action=>"shop_show_website"
  end

  ###
  ##  Controllers For Naigation
  #
  def shop_site_navigation
    @items = WebPage.get_root_node(@shop).children
    return

    root = @shop.content_categories.find_by_category_type(ContentCategory::TYPE_SHOP_ROOT)
    @items = root.children
  end


  #hikaru
  def navigation_update
    @item = @shop.web_pages.find_by_id(params[:id])
    @item.update_attributes(web_page_params)
    unless @item.content_category.blank?
      @item.content_category.title = @item.name
      @item.content_category.save!
    end
    redirect_to :action=>'shop_site_navigation'
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
      fixed_link = WebPage.new(web_page_params)
      fixed_link.shop       = @shop
      fixed_link.parent     = WebPage.get_root_node(@shop)
      fixed_link.page_type  = WebPage::TYPE_LINK
      fixed_link.save
      redirect_to :action=>'shop_site_navigation'
  end

  def shop_create_fixed_page

      content_bag = ContentBag.retrieve_fixed_page_bag(@shop)
#      puts "#"*12+content_bag.id.to_s

      fixed_page = WebPage.new(web_page_params)

      # Allocate Leaf, first
      fixed_leaf = ContentLeaf.new
      fixed_leaf.shop = @shop
      fixed_leaf.title=fixed_page.name
      fixed_leaf.content_bag=content_bag
      fixed_leaf.is_public=true
      fixed_leaf.save!

      # Fix up WebPage
      fixed_page.shop         = @shop
      fixed_page.name         = nil
      fixed_page.content_type = WebPage::TYPE_ANONYMOUS
      fixed_page.page_type    = WebPage::TYPE_FIX
      fixed_page.is_public    = false
      fixed_page.parent       = WebPage.get_root_node(@shop)
      fixed_page.content_key  = fixed_leaf.hash_key
      fixed_page.action_name  = 'fix'
      fixed_page.save!

      redirect_to :action=>'shop_site_navigation'
  end

  def edit_fix_page
    @item = ContentLeaf.find_by_id(params[:id])
  end


  #hikaru
  def update_fix_page
    @item = ContentLeaf.find_by_id(params[:id])
    @item.update_attributes(params[:item])
    redirect_to :action=>'shop_site_navigation'
  end


  #hikaru
  def shop_delete_fixed_link
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

  def list_page_photo
    @item = ContentLeaf.find_by_id(params[:id])
  end

  def new_page_photo
    @item = ContentLeaf.find_by_id(params[:id])
  end

  def create_page_photo
    @item = ContentLeaf.find_by_id(params[:id])
    #@photo = { :image_temp=>"", :image=>params[:file] }
    photo = Photo.new(photo_params)
    photo.shop = @shop
    @item.photos << photo
    redirect_to :action=>"list_page_photo", :id=>@item
  end

  def update_page_photo
    photo = @shop.photos.find(params[:id])
    photo.update_attributes(photo_params)
    redirect_to :action=>"list_page_photo", :id=>photo.ref_id
  end

  def delete_page_photo
    photo = @shop.photos.find(params[:id])
    photo.destroy
    redirect_to :action=>'list_page_photo', :id=>photo.ref_id
  end

protected
  def session_operation
    @shop = current_user.shop
  end

  def shop_params
        params.require(:shop).permit(:alt_id, :name, :business_hour_from, :business_hour_until, :postal, :address_1, :wsite_run_mode, :wsite_keywords, :wsite_description_shop, :wsite_description_business, :wsite_telephone, :telephone_1, :wsite_email, :google_calendar_url, :google_calendar_emb_frame_code, :wsite_layout_pc_specific_basename, :social_facebook_uri, :social_gplus_uri, :social_twitter_uri, :social_pinterest_uri, :social_tumblr_uri, :social_instagram_uri, :use_disqus, :disqus_code, :wsite_ga_code, :analytics_code, :custom_metas, :copyright_notice, :enable_inquiry, :social_hotpepper_beauty_uri, :social_youtube_uri, :social_line_uri)
  end

  def user_params
      params.require(:user).permit(:login, :email, :email_org, :name, :password, :password_confirmation, :role, :company_id, :shop_id, :ui_version)
  end

  def staff_params
      params.require(:staff).permit(:name, :job_title, :staff_status, :description, :social_facebook_uri, :social_gplus_uri, :social_twitter_uri, :social_pinterest_uri, :social_tumblr_uri, :social_instagram_uri, :social_hotpepper_beauty_uri, :social_youtube_uri, :social_line_uri)
  end

  def web_page_params
    params.require(:web_page).permit(:page_type, :shop_id, :parent_id, :template_name, :action_name, :name, :content_type, :is_public, :is_open_new, :external_url)
  end

  def photo_params
    params.require(:photo).permit(:clip, :info)
    #params.permit(:file)
  end
end
