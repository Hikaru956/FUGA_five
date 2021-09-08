# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

class BsCustomerController < ApplicationController
  before_action :authenticate_user!
  before_filter :session_operation
  
  helper  :calendar

  layout  "fuga"

  def index
    @search_shop_id = current_user.shop
  end
  
  
  def list
    @search_alt       = (params[:search_alt].blank?)?       nil: params[:search_alt]
    @search_name      = (params[:search_name].blank?)?      nil: params[:search_name]
    @search_furigana  = (params[:search_furigana].blank?)?  nil: params[:search_furigana]
    @search_telephone = (params[:search_telephone].blank?)? nil: params[:search_telephone]
    @search_telephone = to_sb(@search_telephone)  unless @search_telephone.blank?
    @search_shop_id   = (params[:search_shop_id].blank?)?   nil: params[:search_shop_id]
    
    c = Condition.new
    c.and "1=1", "1=1"
    unless @search_alt.blank? && @search_name.blank? && @search_furigana.blank? && @search_telephone.blank? && @search_shop_id.blank?
      c.and do |cx| 
        cx.and("customers.alt_id",        "LIKE", @search_alt+"%")            unless @search_alt.blank?
        cx.and("customers.name",          "LIKE", "%"+@search_name+"%")       unless @search_name.blank?
        cx.and("customers.furigana",      "LIKE", "%"+@search_furigana+"%")   unless @search_furigana.blank?
        cx.and("customers.telephone",     "LIKE", "%"+@search_telephone+"%")  unless @search_telephone.blank?
        cx.and("customers.shop_id",        @search_shop_id)                   unless @search_shop_id.blank?
      end
    end
    @items  = @shop.customers.paginate(:conditions=>c.where, :select=>"customers.*", :order=>"furigana asc, name asc", :page => params[:page], :per_page=>PER_PAGE)
    @page = params[:page]
  end
  
  def show_property
    @item = Customer.find(params[:id])
  end
  
  def update_customer_age
    if request.post?
      @item = Customer.find(params[:id])
      unless @item.birthday.blank? || params[:new_age].blank?
        @item.birthday = get_birthday(@item.birthday.to_s, params[:new_age])
        @item.save
      end
      redirect_to :action=>"show_property", :id=>@item
    end
  end
  
  def create_customer
    if request.post?
      @item = Customer.new(params[:item])
      @item.telephone = to_sb(@item.telephone)
      if @item.save
        redirect_to :action=>"show_property", :id=>@item
      else
        redirect_to  :action=>"list"
      end
    end
  end
  
  def update_customer
    if request.post?
      @item = Customer.find(params[:id])
      
      @item.birthday      = get_birthday(params[:birthday_string], params[:new_age])
      params[:item][:telephone]     = to_sb(params[:item][:telephone])    unless params[:item][:telephone].blank?
      params[:item][:postal_code]   = to_sb(params[:item][:postal_code])  unless params[:item][:postal_code].blank?
      params[:item][:email]         = to_sb(params[:item][:email])        unless params[:item][:email].blank?
      
      
      @item.update_attributes(params[:item])
      redirect_to :action=>"show_property", :id=>@item
    end
  end
  
  def delete_customer
    if request.post?
      item = Customer.find(params[:id])
      item.destroy
      redirect_to :action=>"list"
    end
  end
  
  def show_initial_qa
    @item = Customer.find(params[:id])
  end
  
  def edit_initial_qa
    @item = Customer.find(params[:id])
  end
  
  def update_initial_qa
    if request.post?
      @item = Customer.find(params[:id])
      if @item.update_attributes(params[:item])
        @item.aspects = collect_aspects_sp
        redirect_to  :action=>"show_initial_qa", :id=>@item
      else
        redirect_to  :action=>"edit_initial_qa", :id=>@item
      end
    end
  end
  
  def list_memo
    @customer = Customer.find(params[:id])
#    @items    = @customer.customer_memos.paginate(:page => params[:page], :order=>["created_at desc"], :per_page=>PER_PAGE)
    @items    = @customer.customer_memos.find(:all, :order=>["created_at desc"])
  end
  
  def show_memo
    @item = CustomerMemo.find(params[:id])
  end
  
  def delete_memo
    if request.post?
      item = CustomerMemo.find(params[:id])
      item.destroy
      if item.customer.blank?
        redirect_to :controller=>"bs_operation", :action=>"memo", :target_date=>item.receipt_on
      else
        redirect_to :action=>"list_memo", :id=>item.customer
      end
    end
  end
  
  def new_memo
    @customer = Customer.find(params[:id])

    @item = CustomerMemo.new
    @item.customer = @customer
    @item.shop = ((session[:shop_id].blank?)? ((@customer.shop.blank?)? nil:  @customer.shop): Shop.find(session[:shop_id]))
    @item.receipt_on = Time.now.to_date
  end

  def create_memo
    if request.post?
      @item = CustomerMemo.new(params[:item])
      @item.price = to_sb(params[:item][:price])  unless params[:item][:price].blank?
      
      @item.memo_on = @item.receipt_on
      if @item.save
        @item.aspects = collect_aspects_sp
        redirect_to :action=>"show_memo", :id=>@item
      else
        redirect_to :action=>"new_memo", :customer_id=>@item.customer
      end
    end
  end
  
  def edit_memo
    @item = CustomerMemo.find(params[:id])
    @customer = @item.customer
  end
  
  def update_memo
    if request.post?
      @item = CustomerMemo.find(params[:id])
      @item.memo_on = @item.receipt_on

      params[:item][:price] = to_sb(params[:item][:price])  unless params[:item][:price].blank?
      if @item.update_attributes(params[:item])
        @item.aspects = collect_aspects_sp
        redirect_to :action=>"show_memo", :id=>@item
      else
        redirect_to :action=>"edit_memo", :id=>@item
      end
    end
  end

  def candidates_for_memo
    @item = CustomerMemo.find(params[:id])
    list
  end
  
  def bind_memo_customer
    if request.post?
      @item = CustomerMemo.find(params[:id])
      @customer = Customer.find(params[:customer])
      @item.customer = @customer
      @item.save
      redirect_to :action=>"show_memo", :id=>@item
    end
  end
  
  def list_receipt
    @customer = Customer.find(params[:id])
#    @items    = @customer.receipts.paginate(:page => params[:page], :order=>["receipt_on desc"], :per_page=>PER_PAGE)
    @items    = @customer.receipts.find(:all, :order=>["receipt_on desc"])
  end
  
  def show_receipt
    @item = Receipt.find(params[:id])
  end

  def create_receipt
    if request.post?
      @item = Receipt.new(params[:item])

      @item.price = to_sb(params[:item][:price])  unless params[:item][:price].blank?
      if @item.save
        redirect_to :action=>"show_receipt", :id=>@item
      else
        redirect_to :action=>"list_receipt", :customer_id=>@item.customer
      end
    end
  end
  
  def delete_receipt
    if request.post?
      item = Receipt.find(params[:id])
      item.destroy
      if item.customer.blank?
        redirect_to :controller=>"bs_operation", :action=>"receipt", :target_date=>item.receipt_on
      else
        redirect_to :action=>"list_receipt", :id=>item.customer
      end
    end
  end
  
  def update_receipt
    if request.post?
      @item = Receipt.find(params[:id])

      params[:item][:price] = to_sb(params[:item][:price])  unless params[:item][:price].blank?
      @item.update_attributes(params[:item])
      redirect_to :action=>"show_receipt", :id=>@item
    end
  end

  def candidates_for_receipt
    @item = Receipt.find(params[:id])
    list
  end
  
  def bind_receipt_customer
    if request.post?
      @item = Receipt.find(params[:id])
      @customer = Customer.find(params[:customer])
      @item.customer = @customer
      @item.save
      redirect_to :action=>"show_receipt", :id=>@item
    end
  end
  
  def create_purchase
    if request.post?
      @item = Purchase.new(params[:item])
      @item.receipt     = Receipt.find(params[:id])
      @item.purchase_on = @item.receipt.receipt_on

      @item.save
      redirect_to :action=>"show_receipt", :id=>@item.receipt
    end
  end

  def update_purchase
    if request.post?
      @item = Purchase.find(params[:id])
      @item.update_attributes(params[:purchase])
      redirect_to :action=>"show_receipt", :id=>@item.receipt
    end
  end

  def delete_purchase
    if request.post?
      item = Purchase.find(params[:id])
      item.destroy
      redirect_to :action=>"show_receipt", :id=>item.receipt
    end
  end

protected
  def session_operation
    @shop = current_user.shop
  end

  def get_birthday(birthday_string, new_age)
    return nil if birthday_string.blank?
    birthday = nil
    begin
      birthday = Time.parse(birthday_string)
      unless new_age.blank?
        age = to_sb(new_age)
        now = Time.now.to_date
        comming_birthday = Time.mktime(now.year, birthday.month, birthday.day, 0, 0, 0).to_date
        
        offset_year = now.year - age.to_i
        offset_year = offset_year-1  if now < comming_birthday

        birthday = Time.mktime(offset_year, birthday.month, birthday.day, 0, 0, 0).to_date
      end
    rescue    
    end
    return birthday
  end
end
