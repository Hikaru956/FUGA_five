# -*- encoding : utf-8 -*-
Fuga326::Application.routes.draw do
  get 'reception/index'
  get 'receptions/index'
  # The priority is based upon order of creation:
  # first created -> highest priority.

#  map.logout '/logout', :controller => 'accounts', :action => 'destroy'
#  map.login '/login', :controller => 'accounts', :action => 'new'
#  map.register '/register', :controller => 'users', :action => 'create'
#  map.signup '/signup', :controller => 'users', :action => 'new'
#  map.resources :users

#  map.resource :account

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  #huikaru
  #resources :users
  #resource :account, :only => [:new, :create, :destroy]

  #hikaru
  devise_for :users, controllers: {
        :registrations => 'users/registrations',
        :sessions => 'users/sessions',
        :passwords => 'users/passwords'
      }
  #
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end

  root :to => 'dashboard#index'
#  match 'signup'    => 'users#new',         :as => :signup
#  match 'register'  => 'users#create',      :as => :register
  #get 'login'     => 'accounts#new',      :as => :login
  #get 'logout'    => 'accounts#destroy',  :as => :logout
  
  #get '/home'       => 'bs_renderer#home',      :as => :home
  get '/home'      => 'dashboard#index',  :as => :home


  get 'bs' ,to: 'bs#index'

  get 'bs_abs_content_bag/json_cat', to: 'bs_abs_content_bag#json_cat'

  get 'bs_config/company_show_shop', to: 'bs_config#company_show_shop'
  patch 'bs_config/company_update_shop', to: 'bs_config#company_update_shop'
  post 'bs_config/shop_create_staff', to: 'bs_config#shop_create_staff'
  patch 'bs_config/shop_update_staff', to: 'bs_config#shop_update_staff'
  delete 'bs_config/shop_delete_staff', to: 'bs_config#shop_delete_staff'
  post 'bs_config/shop_create_user', to: 'bs_config#shop_create_user'
  patch 'bs_config/shop_update_user', to: 'bs_config#shop_update_user'
  delete 'bs_config/shop_delete_user', to: 'bs_config#shop_delete_user'
  patch 'bs_config/shop_update_website', to: 'bs_config#shop_update_website'
  post 'bs_config/shop_create_fixed_link', to: 'bs_config#shop_create_fixed_link'
  post 'bs_config/shop_create_fixed_page', to: 'bs_config#shop_create_fixed_page'
  patch 'bs_config/navigation_update', to: 'bs_config#navigation_update'
  delete 'bs_config/shop_delete_fixed_link', to: 'bs_config#shop_delete_fixed_link'
  post 'bs_config/create_page_photo', to: 'bs_config#create_page_photo'
  delete 'bs_config/delete_page_photo', to: 'bs_config#delete_page_photo'

  post 'bs_config/create_shop_photo', to: 'bs_config#create_shop_photo'
  delete 'bs_config/delete_shop_photo', to: 'bs_config#delete_shop_photo'

  post 'bs_config/create_staff_photo', to:'bs_config#create_staff_photo'
  delete 'bs_config/delete_staff_photo', to:'bs_config#delete_staff_photo'

  post 'bs_config/shop_update_position', to: 'bs_config#shop_update_position'
  delete 'bs_config/shop_delete_position', to:'bs_config#shop_delete_position'

  get 'bs_authoring/index', to: 'bs_authoring#index'
  post 'bs_authoring/create_widget_bag_photo', to: 'bs_authoring#create_widget_bag_photo'
  delete 'bs_authoring/delete_widget_bag_photo', to: 'bs_authoring#delete_widget_bag_photo'
  post 'bs_authoring/update_widget_bag', to: 'bs_authoring#update_widget_bag'
  post 'bs_authoring/layout_for_edit', to: 'bs_authoring#layout_for_edit'
  post 'bs_authoring/layout_for_deploy', to: 'bs_authoring#layout_for_deploy'
  post 'bs_authoring/layout_for_nil', to: 'bs_authoring#layout_for_nil'
  post 'bs_authoring/color_for_deploy', to: 'bs_authoring#color_for_deploy'
  post 'bs_authoring/color_for_edit', to: 'bs_authoring#color_for_edit'
  post 'bs_authoring/color_for_nil', to: 'bs_authoring#color_for_nil'



  post 'dashboard/company_create', to: 'dashboard#company_create'
  patch 'dashboard/company_update', to: 'dashboard#company_update'
  delete 'dashboard/company_delete', to: 'dashboard#company_delete'
  post 'dashboard/company_create_shop', to: 'dashboard#company_create_shop'
  patch 'dashboard/company_update_shop', to: 'dashboard#company_update_shop'
  delete 'dashboard/company_delete_shop', to: 'dashboard#company_delete_shop'
  post 'dashboard/company_create_user', to: 'dashboard#company_create_user'
  patch 'dashboard/company_update_user', to: 'dashboard#company_update_user'
  delete 'dashboard/company_delete_user', to: 'dashboard#company_delete_user'
  post 'dashboard/shop_create_staff', to: 'dashboard#shop_create_staff'
  patch 'dashboard/shop_update_staff', to: 'dashboard#shop_update_staff'
  delete 'dashboard/shop_delete_staff', to: 'dashboard#shop_delete_staff'
  post 'dashboard/shop_create_user', to: 'dashboard#shop_create_user'
  patch 'dashboard/shop_update_user', to: 'dashboard#shop_update_user'
  delete 'dashboard/shop_delete_user', to: 'dashboard#shop_delete_user'
  post 'dashboard/shop_create_favicon', to: 'dashboard#shop_create_favicon'

  post 'dashboard/layout_create', to: 'dashboard#layout_create'
  patch 'dashboard/layout_update', to: 'dashboard#layout_update'
  delete 'dashboard/layout_delete', to: 'dashboard#layout_delete'
  post 'dashboard/create_layout_photo', to: 'dashboard#create_layout_photo'
  delete 'dashboard/delete_layout_photo', to: 'dashboard#delete_layout_photo'
  post 'dashboard/color_create', to: 'dashboard#color_create'
  patch 'dashboard/color_update', to: 'dashboard#color_update'
  delete 'dashboard/color_delete', to: 'dashboard#color_delete'
  post 'dashboard/create_color_photo', to: 'dashboard#create_color_photo'
  delete 'dashboard/delete_color_photo', to: 'dashboard#delete_color_photo'
  post 'dashboard/widget_create', to: 'dashboard#widget_create'
  patch 'dashboard/widget_update', to: 'dashboard#widget_update'
  delete 'dashboard/widget_delete', to: 'dashboard#widget_delete'

  patch 'dashboard/shop_update_website', to: 'dashboard#shop_update_website'
  delete 'dashboard/shop_reset_favicon', to: 'dashboard#shop_reset_favicon'
  post 'dashboard/shop_create_apple_touch_icon', to: 'dashboard#shop_create_apple_touch_icon'
  delete 'dashboard/shop_reset_apple_touch_icon', to: 'dashboard#shop_reset_apple_touch_icon'
  patch 'dashboard/set_disqus_mode', to: 'dashboard#set_disqus_mode'
  patch 'dashboard/set_disqus_code', to: 'dashboard#set_disqus_code'

  post 'dashboard/shop_update_position', to: 'dashboard#shop_update_position'
  delete 'dashboard/shop_delete_position', to: 'dashboard#shop_delete_position'
  post 'dashboard/delegating', to: 'dashboard#delegating'
  post 'dashboard/roll_back', to: 'dashboard#roll_back'


  get 'bs_content_gallery/content_root', to: 'bs_content_gallery#content_root'
  patch 'bs_content_gallery/content_category', to: 'bs_content_gallery#content_category'
  post 'bs_content_gallery/create_bag', to: 'bs_content_gallery#create_bag'
  patch 'bs_content_gallery/update_bag', to: 'bs_content_gallery#update_bag'
  delete 'bs_content_gallery/delete_bag', to: 'bs_content_gallery#delete_bag'
  post 'bs_content_gallery/create_leaf', to: 'bs_content_gallery#create_leaf'
  patch 'bs_content_gallery/update_leaf', to: 'bs_content_gallery#update_leaf'
  delete 'bs_content_gallery/delete_leaf', to: 'bs_content_gallery#delete_leaf'
  post 'bs_content_gallery/create_face_photo', to: 'bs_content_gallery#create_face_photo'
  patch 'bs_content_gallery/update_face_photo', to: 'bs_content_gallery#update_face_photo'
  delete 'bs_content_gallery/delete_face_photo', to: 'bs_content_gallery#delete_face_photo'
  post 'bs_content_gallery/create_photo', to: 'bs_content_gallery#create_photo'
  patch 'bs_content_gallery/update_photo', to: 'bs_content_gallery#update_photo'
  delete 'bs_content_gallery/delete_photo', to: 'bs_content_gallery#delete_photo'
  post 'bs_content_gallery/content_category_create', to: 'bs_content_gallery#content_category_create'
  patch 'bs_content_gallery/content_category_update', to: 'bs_content_gallery#content_category_update'
  delete 'bs_content_gallery/content_category_delete', to: 'bs_content_gallery#content_category_delete'
  
  get 'bs_content_portfolio/content_root', to: 'bs_content_portfolio#content_root'
  patch 'bs_content_portfolio/content_category', to: 'bs_content_portfolio#content_category'
  post 'bs_content_portfolio/create_bag', to: 'bs_content_portfolio#create_bag'
  patch 'bs_content_portfolio/update_bag', to: 'bs_content_portfolio#update_bag'
  delete 'bs_content_portfolio/delete_bag', to: 'bs_content_portfolio#delete_bag'
  post 'bs_content_portfolio/create_leaf', to: 'bs_content_portfolio#create_leaf'
  patch 'bs_content_portfolio/update_leaf', to: 'bs_content_portfolio#update_leaf'
  delete 'bs_content_portfolio/delete_leaf', to: 'bs_content_portfolio#delete_leaf'
  patch 'bs_content_portfolio/content_category_update_description', to: 'bs_content_portfolio#content_category_update_description'
  post 'bs_content_portfolio/create_face_photo', to: 'bs_content_portfolio#create_face_photo'
  patch 'bs_content_portfolio/update_face_photo', to: 'bs_content_portfolio#update_face_photo'
  delete 'bs_content_portfolio/delete_face_photo', to: 'bs_content_portfolio#delete_face_photo'
  post 'bs_content_portfolio/content_category_create', to: 'bs_content_portfolio#content_category_create'
  patch 'bs_content_portfolio/content_category_update', to: 'bs_content_portfolio#content_category_update'
  delete 'bs_content_portfolio/content_category_delete', to: 'bs_content_portfolio#content_category_delete'

  get 'bs_content_news/content_root', to: 'bs_content_news#content_root'
  patch 'bs_content_news/content_category', to: 'bs_content_news#content_category'
  post 'bs_content_news/create_bag', to: 'bs_content_news#create_bag'
  patch 'bs_content_news/update_bag', to: 'bs_content_news#update_bag'
  delete 'bs_content_news/delete_bag', to: 'bs_content_news#delete_bag'
  post 'bs_content_news/create_leaf', to: 'bs_content_news#create_leaf'
  patch 'bs_content_news/update_leaf', to: 'bs_content_news#update_leaf'
  delete 'bs_content_news/delete_leaf', to: 'bs_content_news#delete_leaf'
  post 'bs_content_news/create_photo', to: 'bs_content_news#create_photo'
  delete 'bs_content_news/delete_photo', to: 'bs_content_news#delete_photo'
  post 'bs_content_news/content_category_create', to: 'bs_content_news#content_category_create'
  patch 'bs_content_news/content_category_update', to: 'bs_content_news#content_category_update'
  delete 'bs_content_news/content_category_delete', to: 'bs_content_news#content_category_delete'

  get 'bs_content_stream/content_root', to: 'bs_content_stream#content_root'
  patch 'bs_content_stream/content_category', to: 'bs_content_stream#content_category'
  post 'bs_content_stream/create_bag', to: 'bs_content_stream#create_bag'
  patch 'bs_content_stream/update_bag', to: 'bs_content_stream#update_bag'
  delete 'bs_content_stream/delete_bag', to: 'bs_content_stream#delete_bag'
  post 'bs_content_stream/create_leaf', to: 'bs_content_stream#create_leaf'
  patch 'bs_content_stream/update_leaf', to: 'bs_content_stream#update_leaf'
  delete 'bs_content_stream/delete_leaf', to: 'bs_content_stream#delete_leaf'
  post 'bs_content_stream/create_photo', to: 'bs_content_stream#create_photo'
  patch 'bs_content_stream/update_photo', to: 'bs_content_stream#update_photo'
  delete 'bs_content_stream/delete_photo', to: 'bs_content_stream#delete_photo'
  post 'bs_content_stream/content_category_create', to: 'bs_content_stream#content_category_create'
  patch 'bs_content_stream/content_category_update', to: 'bs_content_stream#content_category_update'
  delete 'bs_content_stream/content_category_delete', to: 'bs_content_stream#content_category_delete'

  post 'bs_content_inquiry/show', to: 'bs_content_inquiry#show'
  patch 'bs_content_inquiry/update', to: 'bs_content_inquiry#update'
  delete 'bs_content_inquiry/delete_inquiry', to: 'bs_content_inquiry#delete_inquiry'

  patch 'bs_attendance/update_business', to: 'bs_attendance#update_business'
  post 'bs_attendance/init_roster', to: 'bs_attendance#init_roster'
  post 'bs_attendance/day_on', to: 'bs_attendance#day_on'
  post 'bs_attendance/day_off', to: 'bs_attendance#day_off'



  get 'bs_roster/index', to: 'bs_roster#index'
  patch 'bs_roster/update_rosters', to: 'bs_roster#update_rosters'
  post 'bs_roster/create', to: 'bs_roster#create'
  patch 'bs_roster/update', to: 'bs_roster#update'
  delete 'bs_roster/delete', to: 'bs_roster#delete'

  post 'bs_reservation/create_reservation', to: 'bs_reservation#create_reservation'
  delete 'bs_reservation/delete_reservation', to: 'bs_reservation#delete_reservation'

  post 'tooltip/reservation/:id', to:'tooltip#reservation'


  get 'news_list'       => 'bs_renderer#news_index',    :as => :news_list
  get 'news'            => 'bs_renderer#news_list',     :as => :news
  get 'news_show'       => 'bs_renderer#news_show',     :as => :news_show
  
  get 'streams'         => 'bs_renderer#stream_index',  :as => :streams
  get 'articles'        => 'bs_renderer#stream_list',   :as => :articles
  get 'article'         => 'bs_renderer#stream_show',   :as => :article

  get 'news_feed'       => 'bs_renderer#news_feed',     :as => :news_feed
  get 'stream_feed'     => 'bs_renderer#stream_feed',   :as => :stream_feed
  
  get 'collcetions'     => 'bs_renderer#gallery_index', :as => :collcetions
  get 'galleries'       => 'bs_renderer#gallery_list',  :as => :galleries
  get 'browse'          => 'bs_renderer#gallery_show',  :as => :browse

  get 'menu_list'       => 'bs_renderer#portfolio_index',   :as => :menu_list
  get 'menu_table'      => 'bs_renderer#portfolio_list',    :as => :menu_table
  get 'menu_show'       => 'bs_renderer#portfolio_show',    :as => :menu_show

  get 'contact_us'      => 'bs_renderer#contact',           :as => :contact_us
  get 'staff'           => 'bs_renderer#staff',             :as => :staff

  get 'fix'             => 'bs_renderer#fix',               :as => :fix

  get 'inquiry_new'     => 'bs_renderer#inquiry_new',       :as => :inquiry_new
  post 'inquiry_create' => 'bs_renderer#inquiry_create',     :as => :inquiry_create


  #  FUGA 5 ADMIN
  get 'admin_index'     => 'admin#index'
  get 'color_list'      => 'admin#color_list'
  get 'layout_list'     => 'admin#layout_list'




#  match '/activate/:activation_code' => 'users#activate', :as => :activate, :activation_code => nil

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  
  
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  get ':controller(/:action(/:id))(.:format)'
end
