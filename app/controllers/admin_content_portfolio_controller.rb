class AdminContentPortfolioController < AdminAbsContentBagController
  before_action :authenticate_user!
  before_action :session_operation
  
  skip_before_action :verify_authenticity_token ,:only=>[:create_photo, :create_face_photo]

  layout  "fuga5"
  
  def content_category
    @parent_category = @shop.content_categories.find_by_id(params[:id])    
    @items = @parent_category.children

    #c = Condition.new
    #c.and "content_leafs.content_category_id", @parent_category.id
    #c.and "1=1", "1=1"
    #@leafs = @shop.content_leafs.paginate(:page => params[:page], :per_page=>PER_PAGE, :conditions=>c.where, :order=>"content_leafs.position asc")
    #@leafs = @shop.content_leafs.find(:all, :conditions=>c.where, :order=>"content_leafs.position asc")

    @leafs = @shop.content_leafs.where("content_leafs.content_category_id =?", @parent_category.id).order('content_leafs.position ASC')
    @leafs = @leafs.to_a.sort{|a,b| a.position<=>b.position}
    @leafs = Kaminari.paginate_array(@leafs).page(params[:page]).per(PER_PAGE)
    #@leafs = @leafs.paginate(:page => params[:page], :per_page=>PER_PAGE)
  end

protected
  def session_operation
    @shop         = current_user.shop
    @content_type = ContentBag::TYPE_PORTFOLIO

    @bag_title = @shop.content_categories.find_by_category_type(@content_type).title
    
    @page         = params[:page]
    @bag          = (params[:hash_bag].blank?)? nil: ContentBag.find_by_hash_key(params[:hash_bag]) 
  end
end
