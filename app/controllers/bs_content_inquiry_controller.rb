class BsContentInquiryController < BsAbsContentBagController
    before_action :authenticate_user!
    before_action :session_operation

    skip_before_action :verify_authenticity_token ,:only=>[:create_photo, :create_face_photo]

    layout  "fuga"

    def index
        @items = @shop.inquiries.order(created_at: :desc)
        @items = @items.paginate(:page => params[:page], :per_page=>PER_PAGE)
    end

    def show
        @inquiry = @shop.inquiries.find(params[:inquiry_id])
    end

    def update
        item = @shop.inquiries.find(params[:inquiry_id])
        item.update_attributes(inquiry_params)
        item.save!
        redirect_to :action=>"show", :id=>@shop.id,:inquiry_id=>item.id
    end

    def delete_inquiry
        item = @shop.inquiries.find(params[:inquiry_id])
        item.destroy
        redirect_to :action=>"index", :id=>@shop.id
    end

private
    def inquiry_params
        params.require(:inquiry).permit(:id, :shop_id, :email, :name, :body, :status, :created_at, :updated_at)
    end
end
