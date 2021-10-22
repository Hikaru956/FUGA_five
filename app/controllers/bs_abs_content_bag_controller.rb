# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

class BsAbsContentBagController < ApplicationController
  before_action :config_x_xss_protection
  before_action :session_operation

  ###
  ##  Actions For General
  #
  def create_bag
    if request.post?
      bag = ContentBag.new(hikaru_params)
      bag.shop = @shop
      bag.content_type = @content_type
      bag.web_page = @shop.web_pages.find_by_content_type(@content_type)
      ContentCategory.register_content_bag(bag)
      redirect_to :action=>"content_root"
    end
  end

  def content_root
    @items = @shop.category_type_root_for(@content_type)
  end

  def bag_category_higher
    bag_category = @shop.content_categories.find(params[:id])
    bag_category.move_higher
    bag_category.save
    redirect_to :action=>'content_root', :hash=>Time.now.to_i
  end

  def bag_category_lower
    bag_category = @shop.content_categories.find(params[:id])
    bag_category.move_lower
    bag_category.save
    redirect_to :action=>'content_root', :hash=>Time.now.to_i
  end

  def update_bag
    if request.post?
      bag = ContentBag.find(params[:id])
      bag.update_attributes(params[:item])
      redirect_to :action=>"content_root"
    end
  end
  
  def delete_bag
    if request.post?
      bag = ContentBag.find(params[:id])
      # Clean with some relations ships up.
      bag.content_category.destroy
      redirect_to :action=>"content_root"
    end
  end
  
  def content_category
    @parent_category = @shop.content_categories.find_by_id(params[:id])    
    @items = @parent_category.children
    
    sons = @parent_category.sons
    sons << @parent_category
    c = Condition.new
    c.and "content_leafs.content_category_id", 'IN', sons
    @leafs = @shop.content_leafs.paginate(:page => params[:page], :per_page=>PER_PAGE, :conditions=>c.where, :order=>'publish_from desc, created_at desc')
  end
  
  def content_category_edit_description
    @item = @shop.content_categories.find_by_id(params[:id])    
  end

  def content_category_update_description
    if request.post?
      @parent_category = @item = @shop.content_categories.find_by_id(params[:id])
      @item.update_attributes(params[:item])
          
      redirect_to :action=>'content_category', :id=>@item
    end    
  end

  
  ###
  ##  Face Operation
  #
  def edit_face
    @parent_category = @shop.content_categories.find_by_id(params[:id])    
  end

  ###
  ##  Actions For Leafs
  #
  def show_leaf
    @page = params[:page]
    @item = @shop.content_leafs.find_by_id(params[:id])
  end

  def new_leaf
    @item                   = ContentLeaf.new
    @item.shop              = @shop
    @item.content_category  = @shop.content_categories.find_by_id(params[:content_category])
    @item.content_bag       = @item.content_category.content_bag
    @item.publish_from      = Time.now.to_date
  end

  def create_leaf
    if request.post?
      @item = ContentLeaf.new(hikaru_params)
      @item.save
      redirect_to :action=>"show_leaf", :id=>@item
    end
  end
  
  def edit_leaf
    @item = @shop.content_leafs.find_by_id(params[:id])
  end

  def update_leaf
    if request.post?
      @item =  @shop.content_leafs.find_by_id(params[:id])
      @item.update_attributes(params[:item])
      redirect_to :action=>"show_leaf", :id=>@item
    end
  end
  
  def delete_leaf
    if request.post?
      item = @shop.content_leafs.find_by_id(params[:id])
      item.destroy
      redirect_to :action=>"content_category", :id=>item.content_category
    end
  end

  def leaf_higher
    leaf = @shop.content_leafs.find(params[:id])
    leaf.move_higher
    leaf.save
    redirect_to :action=>'content_category', :id=>leaf.content_category, :hash=>Time.now.to_i
  end

  def leaf_lower
    leaf = @shop.content_leafs.find(params[:id])
    leaf.move_lower
    leaf.save
    redirect_to :action=>'content_category', :id=>leaf.content_category, :hash=>Time.now.to_i
  end

  ###
  ##  Actions For Category Structure
  #
  def content_category_tree
#    current_category = @shop.content_categories(true).find_by_id(params[:id])
#    category_path = current_category
#    @parent_category = (category_path[0].blank?)? current_category: category_path[0]

    current_category = @shop.content_categories.find_by_id(params[:id])
    @parent_category = current_category.my_bag_root_category
    
#    puts "#"*20+@parent_category.id.to_s
    
#    render :layout=>"fuga_wo_jq"
  end

  def clear_sandbox
    render :update do | page |
      page.replace_html "sandbox", ''     
    end
  end

  def content_category_new
    @item                 = ContentCategory.new
    @item.shop            = @shop
    @item.parent          = @shop.content_categories.find_by_id(params[:parent_id])
    @item.web_page        = @item.parent.web_page 
    @item.category_type   = ContentCategory::TYPE_CATEGORY
    
    render :update do | page |
      page.replace_html "sandbox", :partial=>'content_category_new'      
    end
  end

  def content_category_create
    if request.post?
      @item     = ContentCategory.new(hikaru_params)
      @item.save
      redirect_to(:action=>'content_category_tree', :id=>@item.parent)
    end
  end

  def content_category_edit
    @item = ContentCategory.find(params[:id])
    render :update do | page |
      page.replace_html "sandbox", :partial=>'content_category_edit'  
      page.visual_effect :scrollTo, "overview"
    end
  end

  def content_category_update
    if request.post?
      @item = ContentCategory.find(params[:id])
      @item.update_attributes(params[:item])
      redirect_to(:action=>'content_category_tree', :id=>@item.parent)
    end
  end

  def sort_update
    #render :text => params.inspect

    root = ContentCategory.find(params[:root])
    
    save_tree(params[:tree_], nil, root)
    # 本来は再描画の必要がなければ、以下のrender :nothing => trueでOK。
    # ここではパラメータの内容を確認したいので、render :textで描画してみた。
    render :nothing => true
  end
  
  def save_tree(tree, parent, root)
    tree.each do |order, hash|
      id = hash.delete(:id)
      item = ContentCategory.find(id)
      item.update_attributes(:position=>order, :parent_id=>parent)
      item.parent = root if item.parent.blank?
      item.save!
      save_tree(hash, id, root) unless hash.empty?
    end
  end

  def content_catefory_delete
    if request.post?
      model = ContentCategory.find(params[:id])
      model.destroy
      render :update do | page |
        page.delay(0.2) do 
          page.visual_effect(:fade, "item_#{model.id}", :duration => '1', :delay=>'0')
        end
      end
    end
  end

  ###
  ##  Actions For Photos
  #
  def new_photo
    @item = @shop.content_leafs.find_by_id(params[:id])    
  end

  def create_photo
    if request.post?
      @item = @shop.content_leafs.find_by_id(params[:id]) 
      @photo = { :image_temp=>"", :image=>params[:file] }
      photo = Photo.new(@photo)
      
      # puts "*-"*20
      # puts photo
      # puts "*-"*20
      
      
      photo.shop = @shop
      @item.photos << photo
      redirect_to :action=>"show_leaf", :id=>@item
    end
  end

  def photo_higher
    photo = @shop.photos.find(params[:id])
    photo.move_higher
    photo.save
    redirect_to :action=>'show_leaf', :id=>photo.ref_id, :hash=>Time.now.to_i
  end

  def photo_lower
    photo = @shop.photos.find(params[:id])
    photo.move_lower
    photo.save
    redirect_to :action=>'show_leaf', :id=>photo.ref_id, :hash=>Time.now.to_i
  end

  def update_photo
    if request.post?
      photo = @shop.photos.find(params[:id])
      photo.update_attributes(params[:photo])
      redirect_to :action=>'show_leaf', :id=>photo.ref_id, :hash=>Time.now.to_i
    end
  end
  
  def delete_photo
    if request.post?
      photo = @shop.photos.find(params[:id])
      photo.destroy
      redirect_to :action=>'show_leaf', :id=>photo.ref_id, :hash=>Time.now.to_i
    end
  end

  ###
  ##   Face Photo Operations
  #
  def create_face_photo
    if request.post?
      @item = @shop.content_categories.find_by_id(params[:id]) 
      @photo = { :image_temp=>"", :image=>params[:file] }
      photo = Photo.new(@photo)
      photo.shop = @shop
      @item.photos << photo
      redirect_to :action=>"edit_face", :id=>@item
    end
  end

  def photo_face_higher
    photo = @shop.photos.find(params[:id])
    photo.move_higher
    photo.save
    redirect_to :action=>'edit_face', :id=>photo.ref_id, :hash=>Time.now.to_i
  end

  def photo_face_lower
    photo = @shop.photos.find(params[:id])
    photo.move_lower
    photo.save
    redirect_to :action=>'edit_face', :id=>photo.ref_id, :hash=>Time.now.to_i
  end

  def update_face_photo
    if request.post?
      photo = @shop.photos.find(params[:id])
      photo.update_attributes(params[:photo])
      redirect_to :action=>'edit_face', :id=>photo.ref_id, :hash=>Time.now.to_i
    end
  end
  
  def delete_face_photo
    if request.post?
      photo = @shop.photos.find(params[:id])
      photo.destroy
      redirect_to :action=>'edit_face', :id=>photo.ref_id, :hash=>Time.now.to_i
    end
  end
  
  def json_cat
    @parent = ContentCategory.find_by_id(params[:parent])
    @items = @parent.children

    response.headers['Content-Type'] = 'application/json; charset=utf-8'
    render :layout=>false
  end

  def rename_cat
    target_cat    = ContentCategory.find_by_id(params[:id])
    target_cat.title = params[:text]
    target_cat.save    
    render  :nothing=>true
  end

  def delete_cat
    target_cat    = ContentCategory.find_by_id(params[:id])
    target_cat.destroy    
    render  :nothing=>true
  end
  
  def move_cat
    target_cat    = ContentCategory.find_by_id(params[:id])
    new_parent    = ContentCategory.find_by_id(params[:parent]) || target_cat.my_bag_root_category
    new_position  = params[:position].to_i+1
    
    old_parent  = target_cat.parent
    target_cat.parent = new_parent
    target_cat.position = new_parent.children.size+1  # Fake
    target_cat.save    # Fake
    
    # Reorder Old Parent
    pos = 1
    old_parent.children.each do | cat |
      cat.position = pos
      pos+=1
      cat.save
    end
    
    # Adjust Position In New Parent
    while true
      break if target_cat.position == new_position
      target_cat.move_higher
    end
    render  :nothing=>true
  end

  private
  def config_x_xss_protection
    response.headers['X-XSS-Protection'] = '0'    
  end

  def session_operation
    @shop = Shop.find(params[:id])
  end
end
