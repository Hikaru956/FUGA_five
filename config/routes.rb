# -*- encoding : utf-8 -*-
Fuga326::Application.routes.draw do
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
  devise_for :users

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end

#  match 'signup'    => 'users#new',         :as => :signup
#  match 'register'  => 'users#create',      :as => :register
  #get 'login'     => 'accounts#new',      :as => :login
  #get 'logout'    => 'accounts#destroy',  :as => :logout
  
  #get '/home'       => 'bs_renderer#home',      :as => :home
  get '/home'      => 'dashboard#index',  :as => :home


  get 'bs' ,to: 'bs#index'
  get 'bs_config/company_show_shop' , to: 'bs_config#company_show_shop'

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
  root :to => 'dashboard#index'
  
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  get ':controller(/:action(/:id))(.:format)'
end
