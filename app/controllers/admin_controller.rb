class AdminController < ApplicationController
    before_action :authenticate_user!, except: :index
    before_action :peek_params

    #hikaru
    #before_action :check_super_privilege
    #before_action :check_super_privilege #hikaru :login_required,
    skip_before_action :verify_authenticity_token ,:only=>[:create_color_photo, :create_layout_photo, :shop_create_favicon, :shop_create_apple_touch_icon, :delegating, :roll_back]

    #skip_before_action :verify_authenticity_token ,:only=>[:create_color_photo, :create_layout_photo, :shop_create_favicon, :shop_create_apple_touch_icon]

    layout  "fuga5"

    def index
        unless params[:wkey].blank?
            return redirect_to :controller=>"bs_renderer", :action=>"home", :wkey=>params[:wkey], :search_word=>@search_word
        end
        return redirect_to :action=>"company_index", :search_word=>@search_word
    end

    def delegating
    #    if request.post?
        current_user.shop = Shop.find(params[:id])
        current_user.save
        return redirect_to(:controller=>'admin_config', :action=>'company_show_shop') unless current_user.ui_version.blank?
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
        unless current_user.has_permission?(User::ROLE_OPERATOR)
            return redirect_to(:action=>"company_show", :id=>current_user.company) if current_user.has_permission?(User::ROLE_OWNER)
            return redirect_to(:controller=>'bs_config', :action=>"company_show_shop", :id=>current_user.shop)
        end
        #hikaru
        #@items =Company.paginate(:page => params[:page], :order=>"alt_id asc", :per_page=>PER_PAGE)
        @items = (@search_word.blank?)? Company.all:
                Company.where('companies.alt_id LIKE ? OR companies.name LIKE ? OR companies.postal LIKE ? OR companies.address_1 LIKE ? OR companies.address_2 LIKE ? OR companies.telephone_1 LIKE ? OR companies.telephone_2 LIKE ?', "%#{@search_word}%", "%#{@search_word}%", "%#{@search_word}%", "%#{@search_word}%", "%#{@search_word}%", "%#{@search_word}%", "%#{@search_word}%")
        @items = @items.order(name: :asc)
        @items = @items.paginate(page: params[:page], per_page: 30).order(name: :asc)
    end

    def company_create
        company = Company.new(company_params)
        company.save
        redirect_to :action=>"company_show", :id=>company
    end

    def company_show
        @item = Company.find(params[:id])
    end

    def company_update
        @item = Company.find(params[:id])
        @item.update_attributes(company_params)
        redirect_to :action=>"company_show", :id=>@item
    end

    def company_delete
        item = Company.find(params[:id])
        item.destroy
        redirect_to :action=>"company_index"
    end

    ###
    ##  Controllers For Comapny's User
    #
    def company_list_user
        @item = Company.find(params[:id])
        @users = @item.users.where('role=?',User::ROLE_OWNER)
        #@users = @item.users.find(:all, :conditions=>["role=?",User::ROLE_OWNER])
    end

    def company_create_user
        company = Company.find(params[:id])
        user = User.new(user_params)
        user.company = company
        user.save!
        redirect_to :action=>"company_list_user", :id=>company
    end

    def company_show_user
        @user = User.find(params[:id])
    end

    def company_update_user
        @item = User.find(params[:id])
        if @item.update(user_params)
            @item.try_count=0
            @item.save!
        end
        redirect_to :action=>"company_show_user", :id=>@item
    end

    def company_delete_user
        item = User.find(params[:id])
        item.destroy
        redirect_to :action=>"company_list_user", :id=>item.company
    end

    ###
    ##  Controllers For Shop
    #
    def company_list_shop
        @item = Company.find(params[:id])
    end

    def company_create_shop
        company = Company.find(params[:company_id])
        shop = Shop.new(shop_params)
        shop.company = company
        shop.save!
        redirect_to :action=>"company_show_shop", :id=>shop.id
    end

    def company_show_shop
        @shop = @item = Shop.find(params[:id])
        render :layout=>"fuga5"
    end

    def company_update_shop
        @item = Shop.find(params[:id])
        @item.update_attributes(shop_params)
        redirect_to :action=>"company_show_shop", :id=>@item
    end

    def company_update_shop_room
        @item = Shop.find(params[:id])
        @item.update_attributes(shop_params)
        redirect_to :action=>"company_show_shop_usage", :id=>@item
    end

    def company_show_shop_usage
        @shop = @item = Shop.find(params[:id])
    end

    def company_delete_shop
        item = Shop.find_by(id: params[:id])
        redirect_to :action=>"index" if item.blank?
        #logger.error '■　■　■　■　■　■　■　■　'
        #item = Shop.find_by(id: params[:id])
        #item.web_pages.map{|p| p.destroy}
        #item = Shop.find_by(id: params[:id])
        #item.content_categories.map{|p| p.destroy}
        item.destroy
        redirect_to :action=>"company_list_shop", :id=>item.company
    end

    def shop_edit_position
        @item = Shop.find(params[:id])
        render :layout=>"fuga5"
    end

    def shop_update_position
        @item = Shop.find(params[:id])
        @item.lat = params[:lat]
        @item.lng = params[:lng]
        @item.save!
        redirect_to :action=>"company_show_shop", :id=>@item
    end

    def shop_delete_position
        @item = Shop.find(params[:id])
        @item.lat = nil
        @item.lng = nil
        @item.save!
        redirect_to :action=>"company_show_shop", :id=>@item
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
        @staffs = @item.staffs.order(position: :asc)
    end

    def shop_create_staff
        shop = Shop.find(params[:shop_id])
        staff = Staff.new(staff_params)
        staff.shop = shop
        staff.save
        redirect_to :action=>"shop_show_staff", :id=>staff
    end

    def shop_show_staff
        @staff = Staff.find(params[:id])
    end

    def shop_update_staff
        @item = Staff.find(params[:id])
        @item.update_attributes(staff_params)
        redirect_to :action=>"shop_show_staff", :id=>@item
    end

    def shop_delete_staff
        item = Staff.find(params[:id])
        item.destroy
        redirect_to :action=>"shop_list_staffs", :id=>item.shop
    end

    def staff_higher
        staff = Staff.find(params[:id])
        staff.move_higher
        staff.save

        @item = staff.shop
        redirect_to :action=>'shop_list_staffs', :id=>@item
    end

    def staff_lower
        staff = Staff.find(params[:id])
        staff.move_lower
        staff.save

        @item = staff.shop
        redirect_to :action=>'shop_list_staffs', :id=>@item
    end


    ###
    ##  Controllers For Shop Users
    #
    def shop_list_users
        @item = Shop.find(params[:id])
        @users = @item.users
    end

    def shop_create_user
        shop = Shop.find(params[:shop_id])
        user = User.new(user_params)
        user.company  = shop.company
        user.shop     = shop
        user.save
        unless user.valid?
            flash[:alert] = '新規ユーザーの作成に失敗しました (ログインIDの重複など)。'
        end
        redirect_to :action=>"shop_list_users", :id=>shop
    end

    def shop_show_user
        @user = User.find(params[:id])
    end

    def shop_update_user
        @item = User.find(params[:id])
        @item.update_attributes(user_params)
        unless @item.valid?
            flash[:alert] = 'ユーザーの更新に失敗しました(ログインIDの重複など)'
        end
        redirect_to(:action=>"shop_show_user", :id=>@item)
    end

    def shop_update_user_ui
        @item = User.find(params[:id])
        @item.update_attributes(user_params)
        redirect_to root_path
    end

    def shop_delete_user
        item = User.find(params[:id])
        item.destroy
        redirect_to :action=>"shop_list_users", :id=>item.shop
    end

    ###
    ##  Controllers For WebSite Properties
    #
    def shop_show_website
        @shop = Shop.find(params[:id])
    end

    def shop_update_website
        @item = Shop.find(params[:id])
        @item.update_attributes(shop_params)
        redirect_to :action=>"shop_show_website", :id=>@item
    end

    def shop_new_favicon
        @shop = Shop.find(params[:id])
    end

    def shop_new_apple_touch_icon
        @shop = Shop.find(params[:id])
    end

    def shop_create_favicon
        @shop = Shop.find(params[:id])
        ###
        ##  Clear Current Favicon
        #
        WebPage.reset_favicon(@shop)
        photo = Photo.new(photo_params)
        photo.shop = @shop
        photo.ref = WebPage.get_root_node(@shop)
        photo.save!

        redirect_to :action=>"shop_show_website", :id=>@shop
    end

    def shop_create_apple_touch_icon
        @shop = Shop.find(params[:id])
        ###
        ##  Clear Current Apple Touch Icon
        #
        WebPage.reset_apple_touch_icon(@shop)
        photo = Photo.new(photo_params)
        photo.shop = @shop
        photo.ref = WebPage.get_root_node(@shop)
        photo.save!

        redirect_to :action=>"shop_show_website", :id=>@shop
    end

    def shop_reset_favicon
        @shop = Shop.find(params[:id])
        WebPage.reset_favicon(@shop)
        redirect_to :action=>"shop_show_website", :id=>@shop
    end

    def shop_reset_apple_touch_icon
        @shop = Shop.find(params[:id])
        WebPage.reset_apple_touch_icon(@shop)
        redirect_to :action=>"shop_show_website", :id=>@shop
    end

    def set_disqus_mode
        @shop = Shop.find(params[:id])
        @shop.update_attributes(shop_params)
        redirect_to :action=>"shop_show_website", :id=>@shop
    end

    def set_disqus_code
        @shop = Shop.find(params[:id])
        @shop.update_attributes(shop_params)
        redirect_to :action=>"shop_show_website", :id=>@shop
    end

    ###
    ##  Controllers For Admin. Users
    #
    def user_list
        @users = User.where("   role >?
                            AND role <=?", \
                            User::ROLE_OWNER, current_user.role).order(role: :desc, name: :asc)
    end

    def user_create
        new_user = User.new(user_params)
        new_user = new_user.save
        unless new_user.valid?
            flash[:alert] = '新規ユーザーの作成に失敗しました (ログインIDの重複など)。'
        end
        redirect_to :action=>"user_list"
    end

    def user_show
        @user = User.find(params[:id])
    end

    def user_update
        @item = User.find(params[:id])
        if @item.update_attributes(user_params)
            @item.try_count=0
            @item.save!
            unless @item.valid?
                flash[:alert] = 'ユーザーの更新に失敗しました(ログインIDの重複など)'
            end
        end
        redirect_to(:controller=>'dashboard', :action=>"user_show", :id=>@item) if @item.ui_version.blank?
        redirect_to(:action=>"user_show", :id=>@item) unless @item.ui_version.blank?
    end

    def user_delete
        item = User.find(params[:id])
        item.destroy
        redirect_to :action=>"user_list"
    end

    ###
    ##  Controllers For ColorSchemes
    #
    def color_list
        @colors = ColorScheme.all
        @colors = @colors.order(position: :asc)
    end

    def color_create
        color = ColorScheme.new(color_scheme_params)
        color.save
        redirect_to :action=>"color_show", :id=>color
    end

    def color_show
        @color = ColorScheme.find(params[:id])
    end

    def color_update
        @item = ColorScheme.find(params[:id])
        @item.update_attributes(color_scheme_params)
        redirect_to :action=>"color_show", :id=>@item
    end

    def color_delete
        item = ColorScheme.find(params[:id])
        item.destroy
        redirect_to :action=>"color_list"
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
        @item = ColorScheme.find(params[:id])
        photo = Photo.new(photo_params)
        photo.shop = nil
        @item.photo = photo
        @item.save
        redirect_to :action=>"color_show", :id=>@item
    end

    def delete_color_photo
        photo = Photo.find(params[:id])
        photo.destroy
        redirect_to :action=>'color_show', :id=>photo.ref_id, :hash=>Time.now.to_i
    end

    ###
    ##  Controllers For LayoutSchemes
    #
    def layout_list
        @layouts = LayoutScheme.all
        @layouts = @layouts.order(position: :asc)
    end

    def layout_create
        layout = LayoutScheme.new(layout_scheme_params)
        layout.save
        redirect_to :action=>"layout_show", :id=>layout
    end

    def layout_show
        @layout = LayoutScheme.find(params[:id])
    end

    def layout_update
        @item = LayoutScheme.find(params[:id])
        @item.update_attributes(layout_scheme_params)
        redirect_to :action=>"layout_show", :id=>@item
    end

    def layout_delete
        item = LayoutScheme.find(params[:id])
        item.destroy
        redirect_to :action=>"layout_list"
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
        @item = LayoutScheme.find(params[:id])
        photo = Photo.new(photo_params)
        photo.shop = nil
        @item.photo = photo
        @item.save
        redirect_to :action=>"layout_show", :id=>@item
    end

    #def create_layout_photo
    #    @item = LayoutScheme.find(params[:id])
    #    @photo = { :image_temp=>"", :image=>params[:file] }
    #    photo = Photo.new(@photo)
    #    photo.shop = nil
    #    @item.photo = photo
    #    redirect_to :action=>"layout_show", :id=>@item
    #end

    def delete_layout_photo
        photo = Photo.find(params[:id])
        photo.destroy
        redirect_to :action=>'layout_show', :id=>photo.ref_id, :hash=>Time.now.to_i
    end

    def widget_list
        @layout = LayoutScheme.find(params[:id])
    end

    ###
    ##  Visual Widget
    #
    def widget_create
        visual_widget = VisualWidget.new(visual_widget_params)
        visual_widget.save
        redirect_to :action=>"widget_list", :id=>visual_widget.layout_scheme
    end

    def widget_update
        @item = VisualWidget.find(params[:id])
        @item.update_attributes(visual_widget_params)
        redirect_to :action=>"widget_list", :id=>@item.layout_scheme
    end

    def widget_delete
        @item = VisualWidget.find(params[:id])
        @item.destroy
        redirect_to :action=>"widget_list", :id=>@item.layout_scheme
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

    #hikaru
    private
    def peek_params
        @search_word = params[:search_word]
    end

    def company_params
        params.require(:company).permit(:alt_id, :name, :telephone_1, :postal, :address_1)
    end

    def layout_scheme_params
        params.require(:layout_scheme).permit(:is_public, :name, :description, :position, :repository_path)
    end

    def color_scheme_params
        params.require(:color_scheme).permit( :is_public, :name, :description, :position, :repository_path)
    end

    def photo_params
        params.require(:photo).permit(:clip, :info)
        #params.permit(:file)
    end

    def visual_widget_params
        params.require(:item).permit(:layout_scheme_id, :hash_key, :position, :title, :description, :widget_type, :created_at, :updated_at)
    end
    def shop_params
        params.require(:shop).permit(:alt_id, :name, :business_hour_from, :business_hour_until, :postal, :address_1, :wsite_run_mode, :wsite_keywords, :wsite_description_shop, :wsite_description_business, :wsite_telephone, :telephone_1, :wsite_email, :inquiry_email, :google_calendar_url, :google_calendar_emb_frame_code, :wsite_layout_pc_specific_basename, :social_facebook_uri, :social_gplus_uri, :social_twitter_uri, :social_pinterest_uri, :social_tumblr_uri, :social_instagram_uri, :use_disqus, :disqus_code, :wsite_ga_code, :analytics_code, :custom_metas, :copyright_notice, :social_hotpepper_beauty_uri, :social_youtube_uri, :social_line_uri, :enable_inquiry, :room_size_mb, :web_reservation_uri, :option_attendance_management, :option_reservation_management)
    end

    def user_params
            params.require(:user).permit(:login, :email, :email_org, :name, :password, :password_confirmation, :role, :company_id, :shop_id, :ui_version)
    end

    def staff_params
        params.require(:staff).permit(:name, :job_title, :staff_status, :description, :social_facebook_uri, :social_gplus_uri, :social_twitter_uri, :social_pinterest_uri, :social_tumblr_uri, :social_instagram_uri, :social_hotpepper_beauty_uri, :social_line_uri, :web_reservation_uri)
    end

end
