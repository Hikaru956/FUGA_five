class AdminReservationController < ApplicationController
    before_action :authenticate_user!
    before_action :session_operation

    layout  "fuga5"

    def index
        redirect_to :action=>"reservation", :shop_id=>current_user.shop, :target_date=>params[:target_date]
    end
    
    def reservation
        @shop = current_user.shop
        @target_date = (params[:target_date].blank?)? Time.now.to_date: parse_date(params[:target_date])
    end

    def reservation_calendar
        @shop = current_user.shop
        @target_date = (params[:target_date].blank?)? Time.now.to_date: parse_date(params[:target_date])
    end

    def birthday
        @shop = current_user.shop
        @target_date = (params[:target_date].blank?)? Time.now.to_date: parse_date(params[:target_date])
    end
    
    def birthday_calendar
        @shop = current_user.shop
        @target_date = (params[:target_date].blank?)? Time.now.to_date: parse_date(params[:target_date])
    end

    def new_reservation
        @item       = Reservation.new
        @item.shop  = @shop = current_user.shop
        @item.staff =  (params[:staff_id].blank?)? nil: @shop.staffs.find_by_id(params[:staff_id])
        
        begin
        @target_date = Time.parse(params[:target_date]).to_date
        rescue
        @target_date = Time.now.to_date
        end
        @item.reserved_on = Time.local(@target_date.year, @target_date.month, @target_date.day, 9, 0, 0)
        @item.min_period  = 60
    end

    def create_reservation
        @item = Reservation.new(reservation_params)
        @item.reserved_until = (params[:reserved_on].to_i) + (params[:min_period].to_i*60)


        #@target_date        = (params[:item][:target_date].blank?)? Time.now.to_date: parse_date(params[:item][:target_date])
        #base_time           = Time.mktime(@target_date.year, @target_date.month, @target_date.day, 0, 0, 0)
        #@item.reserved_on   = base_time + (params[:item][:start_hour].to_i*60*60) + (params[:item][:start_min].to_i*60)
            
        @item.save!
        redirect_to :action=>"show_reservation", :id=>@item
    end

    def show_reservation
        @shop = current_user.shop
        @item = @shop.reservations.find_by_id(params[:id])
        @target_date = @item.reserved_on.to_date 
    end

    def edit_reservation
        @shop = current_user.shop
        @item = @shop.reservations.find_by_id(params[:id])
        @target_date = @item.reserved_on.to_date 
    end

    def update_reservation
        @shop = current_user.shop
        @item = @shop.reservations.find_by_id(params[:id])
        
        #@target_date = @item.reserved_on.to_date 
        #base_time           = Time.mktime(@target_date.year, @target_date.month, @target_date.day, 0, 0, 0)
        #@item.reserved_on   = base_time + (params[:start_hour].to_i*60*60) + (params[:start_min].to_i*60)

        @item.update_attributes(reservation_params)
        @item.reserved_until = (params[:reserved_on].to_i) + (params[:min_period].to_i*60)
        @item.save
        redirect_to :action=>"show_reservation", :id=>@item
    end

    def delete_reservation
        reservation = Reservation.find(params[:id])
        reservation.destroy

        @target_date = reservation.reserved_on.to_date
        redirect_to :action=>"reservation", :target_date=>@target_date
    end

    def new_reservation_customer
        @reservation = Reservation.find(params[:id])
        @item = Customer.new
        render :update do | page |
        page.replace_html "sandbox", :partial=>'new_reservation_customer'      
    #      page.visual_effect(:highlight, "sandbox", :duration=>1.0, :startcolor => "#88ff88")
    #      page.visual_effect :scrollTo, "sandbox"
        end
    end

    def create_reservation_customer
        @reservation = @item = Reservation.find(params[:id])
        @customer = Customer.new(hikaru_params)
        @customer.save

        @reservation.customer = @customer
        @reservation.save
        
        redirect_to :action=>"show_reservation", :id=>@reservation
    end
    
    def release_reservation_customer
        @item = Reservation.find(params[:id])
        @item.customer = nil
        @item.save
        redirect_to :action=>"show_reservation", :id=>@item
    end
    
    def search_reservation_customer
        @reservation    = Reservation.find(params[:id])
        @search_string  = params[:search_string]

        render :update do | page |
        page.replace_html "sandbox", :partial=>'search_reservation_customer'      
        end
    end

    def list_reservation_customer
        @search_string = params[:search_string]
        @reservation = Reservation.find(params[:id])

        unless @search_string.blank?
        @items = Customer.where("customers.name LIKE (?) OR customers.furigana LIKE (?) OR customers.telephone LIKE (?)", "%"+@search_string+"%", "%"+@search_string+"%", "%"+@search_string+"%")
        end

        @items = @items.order(furigana: :asc, name: :asc).paginate(:page => params[:page], :per_page=>PER_PAGE)

        #c = Condition.new
        #unless @search_string.blank?
        #  c.and do |cx|
        #    cx.or("customers.name",           "LIKE", "%"+@search_string+"%")  
        #    cx.or("customers.furigana",       "LIKE", "%"+@search_string+"%")  
        #    cx.or("customers.telephone",    "LIKE", "%"+@search_string+"%")  
        #  end
        #end
        #@items  = Customer.paginate(:conditions=>c.where, :select=>"customers.*", :order=>"furigana asc, name asc", :page => params[:page], :per_page=>PER_PAGE)    

        render :update do | page |
        page.replace_html "sandbox", :partial=>'list_reservation_customer'      
        end
    end

    def map_reservation_customer
        @reservation = @item = Reservation.find(params[:id])
        @customer = Customer.find(params[:customer])

        @reservation.customer = @customer
        @reservation.save
        
        redirect_to :action=>"show_reservation", :id=>@reservation
    end

    protected
    def session_operation
        @shop = current_user.shop
    end

    def reservation_params
        params.require(:reservation).permit(:id, :customer_id, :shop_id, :staff_id, :reserved_on, :reserved_until, :min_period, :memo_1, :memo_2)
    end
end
