class AdminContentNewsController < AdminAbsContentBagController
    before_action :authenticate_user!
    before_action :session_operation
    
    skip_before_action :verify_authenticity_token ,:only=>[:create_photo]

    layout  "fuga5"
    
    def content_category
        @parent_category = @shop.content_categories.find_by_id(params[:id])    
        @items = @parent_category.children
        
        #hikaru
        #c = Condition.new
        #c.and "content_leafs.content_category_id", @parent_category.id
        #@leafs = ContentLeaf.paginate(:page => params[:page], :per_page=>PER_PAGE, :conditions=>c.where, :order=>"position desc")

        @leafs = ContentLeaf.where("content_leafs.content_category_id =?", @parent_category.id).order(position: :desc)
        @leafs = @leafs.paginate(:page => params[:page], :per_page=>PER_PAGE)

    end

    protected
    def session_operation
        @shop         = current_user.shop
        @content_type = ContentBag::TYPE_NEWS

        @bag_title = @shop.content_categories.find_by_category_type(@content_type).title
        
        @page         = params[:page]
        @bag          = (params[:hash_bag].blank?)? nil: ContentBag.find_by_hash_key(params[:hash_bag]) 
    end
end
