class AdminAbsContentBagController < ApplicationController
    before_action :config_x_xss_protection
    before_action :session_operation

    ###
    ##  Actions For General
    #
    def create_bag
        bag = ContentBag.new(content_bag_params)
        bag.shop = @shop
        bag.content_type = @content_type
        bag.web_page = @shop.web_pages.find_by_content_type(@content_type)
        ContentCategory.register_content_bag(bag)
        redirect_to :action=>"content_root"
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
        bag = ContentBag.find(params[:id])
        bag.update_attributes(content_bag_params)
        redirect_to :action=>"content_root"
    end
    
    def delete_bag
        bag = ContentBag.find(params[:id])
        # Clean with some relations ships up.
        bag.content_category.destroy
        redirect_to :action=>"content_root"
    end
    
    def content_category
        @parent_category = @shop.content_categories.find_by_id(params[:id])    
        @items = @parent_category.children
        
        sons = @parent_category.sons
        sons << @parent_category
        #hikaru
        #c = Condition.new
        #c.and "content_leafs.content_category_id", 'IN', sons
        #@leafs = @shop.content_leafs.paginate(:page => params[:page], :per_page=>PER_PAGE, :conditions=>c.where, :order=>'publish_from desc, created_at desc')

        @leafs = @shop.content_leafs.where("content_leafs.content_category_id IN (?)", sons).order(publish_from: :desc).order(created_at: :desc)
        @leafs = @leafs.paginate(:page => params[:page], :per_page=>PER_PAGE)
    end
    
    def content_category_edit_description
        @item = @shop.content_categories.find_by_id(params[:id])    
    end

    def content_category_update_description
        @parent_category = @item = @shop.content_categories.find_by_id(params[:id])
        @item.update_attributes(content_category_params)
        redirect_to :action=>'content_category', :id=>@item
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
        #logger.error '■ ■ ■ '+@shop.name+' '+@shop.id.to_s
        @page = params[:page]
        @item = @shop.content_leafs.find_by_id(params[:id])
        #@item = ContentLeaf.find_by_id(params[:id])
    end

    def new_leaf
        @item                   = ContentLeaf.new
        @item.shop              = @shop
        @item.content_category  = @shop.content_categories.find_by_id(params[:content_category])
        @item.content_bag       = @item.content_category.content_bag || ContentBag.find_by(id: params[:content_bag])
        @item.publish_from      = Time.now.to_date
        @item.save!
        redirect_to :action=>"edit_leaf", :id=>@item.id
    end

    def create_leaf
        @item = ContentLeaf.new(content_leafs_params)
        @item.content_bag = @item.content_category.content_bag  if @item.content_bag.blank?
        @item.save!
        redirect_to :action=>"show_leaf", :id=>@item
    end
    
    def edit_leaf
        @item = @shop.content_leafs.find_by_id(params[:id])
    end

    def update_leaf
        @item =  @shop.content_leafs.find_by_id(params[:id])
        @item.tag_list.remove(@item.tag_list)
        @item.update_attributes(content_leafs_params)
        redirect_to :action=>"show_leaf", :id=>@item
    end
    
    def delete_leaf
        item = @shop.content_leafs.find_by_id(params[:id])
        item.destroy
        redirect_to :action=>"content_category", :id=>item.content_category
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

    def move_to_top
        leaf = @shop.content_leafs.find(params[:id])
        leaf.move_to_top
        leaf.save
        redirect_to :action=>'content_category', :id=>leaf.content_category, :hash=>Time.now.to_i
    end

    def move_to_bottom
        leaf = @shop.content_leafs.find(params[:id])
        leaf.move_to_bottom
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

        @current_category = @shop.content_categories.find_by_id(params[:id])
        @parent_category = @current_category.my_bag_root_category
        
    #    puts "#"*20+@parent_category.id.to_s
        
    #    render :layout=>"fuga_wo_jq"
    end

    def content_category_higher
        content_category = @shop.content_categories.find(params[:id])
        content_category.move_higher
        content_category.save
        #bag_category = @shop.content_categories.find(params[:id])
        #bag_category.move_higher
        #bag_category.save
        redirect_to :action=>'content_category_tree', :hash=>Time.now.to_i, :id=>content_category.parent.id
    end

    def content_category_lower
        content_category = @shop.content_categories.find(params[:id])
        content_category.move_lower
        content_category.save
        #bag_category = @shop.content_categories.find(params[:id])
        #bag_category.move_lower
        #bag_category.save
        redirect_to :action=>'content_category_tree', :hash=>Time.now.to_i, :id=>content_category.parent.id
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
        @item     = ContentCategory.new(content_category_params)
        @item.save!
        redirect_to(:action=>'content_category_tree', :id=>@item.parent)
    end

    def content_category_edit
        @item = ContentCategory.find(params[:id])
        render :update do | page |
        page.replace_html "sandbox", :partial=>'content_category_edit'
        page.visual_effect :scrollTo, "overview"
        end
    end

    def content_category_update
        @item = ContentCategory.find(params[:id])
        @item.update_attributes(content_category_params)
        redirect_to(:action=>'content_category_tree', :id=>@item.parent.id)
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

    def content_category_delete
        model = ContentCategory.find(params[:id])
        model.destroy
        redirect_to(:action=>'content_category_tree', :id=>model.parent.id)
    #      render :update do | page |
    #        page.delay(0.2) do 
    #          page.visual_effect(:fade, "item_#{model.id}", :duration => '1', :delay=>'0')
    #        end
    #      end
    end

    ###
    ##  Actions For Photos
    #
    def new_photo
        @item = @shop.content_leafs.find_by_id(params[:id])    
    end

    def create_photo
        @item = @shop.content_leafs.find_by_id(params[:id]) 
        photo = Photo.new(photo_params)
        photo.shop = @shop
        @item.photos << photo
        @item.photos.build
        redirect_to :action=>"show_leaf", :id=>@item
    end

    def create_image
        shop_id = params[:shop_id]
        ref_id = params[:ref_id]
        photo = params[:photo]

        content_leaf = ContentLeaf.find(ref_id) unless ref_id.blank?

        # デバッグ用ログ
        Rails.logger.debug("Received Photo: #{photo.inspect}")
        Rails.logger.debug("Original Filename: #{photo.original_filename}")
        Rails.logger.debug("Content Type: #{photo.content_type}")

        # HEIFやWebP形式の画像をPNG形式に変換
        if photo.content_type != 'image/png' && photo.content_type != 'image/jpeg'
            require 'mini_magick'

            # 一時ファイルのパス
            temp_file = Tempfile.new(['temp', '.png'])
            temp_file.binmode # Ensure binary mode for image processing

            begin
                # MiniMagickを使用して変換
                image = MiniMagick::Image.read(photo.read)

                # デバッグ用ログ
                Rails.logger.debug("Temp File Path Before Format: #{temp_file.path}")

                image.format('png')
                image.write(temp_file.path)

                # デバッグ用ログ
                Rails.logger.debug("Temp File Path After Format: #{temp_file.path}")

                # 変換後の画像をアップロード
                photo = ActionDispatch::Http::UploadedFile.new(
                    tempfile: temp_file,
                    filename: "#{File.basename(photo.original_filename, '.*')}.png",
                    content_type: 'image/png',
                    headers: {
                        "Content-Disposition" => "form-data; name=\"photo\"; filename=\"#{File.basename(photo.original_filename, '.*')}.png\"",
                        "Content-Type" => 'image/png'
                    }
                )

                # デバッグ用のログ
                Rails.logger.debug("Image successfully converted to PNG.")
            rescue => e
                Rails.logger.error("Image conversion failed: #{e.message}")
                raise
            end
        end

        # ここでphotoオブジェクトをログに出力して確認する
        Rails.logger.debug("Photo Object Before Saving: #{photo.inspect}")

        # ファイルをアップロードして写真のインスタンスを作成
        photo_record = Photo.new(shop_id: shop_id, ref: content_leaf, clip: photo)

        respond_to do |format|
            if photo_record.save
                format.json { render json: { url: photo_record.clip.url, id: photo_record.id } }
            else
                format.json { render json: { errors: photo_record.errors.full_messages }, status: :unprocessable_entity }
            end
        end
    end


    def delete_image
        @photo = Photo.find_by(id: params[:id])
        
        if @photo
            if @photo.destroy
                render json: { status: :ok }
            else
                render json: { error: '写真の削除に失敗しました' }, status: :unprocessable_entity
            end
        else
            render json: { error: '写真が見つかりません' }, status: :not_found
        end
    end

    #def create_photo
    #  if request.post?
    #    @item = @shop.content_leafs.find_by_id(params[:id]) 
    #    @photo = { :image_temp=>"", :image=>params[:file] }
    #    photo = Photo.new(@photo)
        
        # puts "*-"*20
        # puts photo
        # puts "*-"*20
        
        
    #    photo.shop = @shop
    #    @item.photos << photo
    #    redirect_to :action=>"show_leaf", :id=>@item
    #  end
    #end

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

    def photo_to_top
        photo = @shop.photos.find(params[:id])
        photo.move_to_top
        photo.save
        redirect_to :action=>'show_leaf', :id=>photo.ref_id, :hash=>Time.now.to_i
    end

    def photo_to_bottom
        photo = @shop.photos.find(params[:id])
        photo.move_to_bottom
        photo.save
        redirect_to :action=>'show_leaf', :id=>photo.ref_id, :hash=>Time.now.to_i
    end

    def update_photo
        photo = @shop.photos.find(params[:id])
        photo.update_attributes(photo_params)
        redirect_to :action=>'show_leaf', :id=>photo.ref_id, :hash=>Time.now.to_i
    end
    
    def delete_photo
        photo = @shop.photos.find(params[:id])
        photo.destroy
        redirect_to :action=>'show_leaf', :id=>photo.ref_id, :hash=>Time.now.to_i
    end

    ###
    ##   Face Photo Operations
    #
    def create_face_photo
        @item = @shop.content_categories.find_by_id(params[:id]) 
        photo = Photo.new(photo_params)
        photo.shop = @shop
        @item.photos << photo
        @item.photos.build
        redirect_to :action=>"edit_face", :id=>@item
    end


    #def create_face_photo
    #    @item = @shop.content_categories.find_by_id(params[:id]) 
    #    @photo = { :image_temp=>"", :image=>params[:file] }
    #    photo = Photo.new(@photo)
    #    photo.shop = @shop
    #    @item.photos << photo
    #    redirect_to :action=>"edit_face", :id=>@item
    #end

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
        photo = @shop.photos.find(params[:id])
        photo.update_attributes(photo_params)
        redirect_to :action=>'edit_face', :id=>photo.ref_id, :hash=>Time.now.to_i
    end
    
    def delete_face_photo
        photo = @shop.photos.find(params[:id])
        photo.destroy
        redirect_to :action=>'edit_face', :id=>photo.ref_id, :hash=>Time.now.to_i
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

    def content_bag_params
        params.require(:content_bag).permit(:id, :shop_id, :parent_id, :position, :hash_key, :content_type, :contemy_categoru_id, :web_page_id, :name, :description, :is_public)
    end

    def content_leafs_params
        params.require(:content_leaf).permit(:id, :shop_id, :content_bag_id, :content_category_id, :staff_id, :position, :title, :description, :description_2, :description_3, :is_public, :publish_from, :publish_until, tag_list: [])
    end

    def content_category_params
        params.require(:content_category).permit(:id, :shop_id, :parent_id, :position, :category_type, :web_page_id, :title, :description, :description_2, :description_3, :is_public)
    end

    def photo_params
        params.require(:photo).permit(:clip, :info, :shop_id)
        #params.permit(:file)
    end

    def session_operation
        @shop = Shop.find_by_id(params[:id])
        @shop = Shop.find_by_id(params[:hikaru]) if @shop.blank?
    end
end
