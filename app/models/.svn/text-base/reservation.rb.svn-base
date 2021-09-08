# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

class Reservation < ActiveRecord::Base
  belongs_to  :customer
  belongs_to  :shop
  belongs_to  :staff

  validate  :valid_reservation?
  
  before_save   :before_save
  after_save    :after_save
  after_destroy :after_destroy
  
  def before_save
    self.reserved_until = self.reserved_on+(self.min_period*60)
  end
  
  def after_save
  end

  def after_destory
  end
  
  def fixed?
    return !self.purchase.blank?
  end

  def blocked?
    return self.product.blank?
  end

  ###  
  ## UTIITIES
  ##
  def self.sumup_price(collections)
    total = 0
    collections.each { |r| total+= r.price }
    total
  end

  def self.in_range(time_reserved_on, time_reserved_until, shop=nil, staff=nil, customer=nil)
    c = timeline_condition(time_reserved_on, time_reserved_until)
    c.and "reservations.shop_id",       shop.id        unless shop.blank?
    c.and "reservations.staff_id",      staff.id       unless staff.blank?
    c.and "reservations.customer_id",   customer.id    unless customer.blank?
    
    Reservation.find(:all, :conditions=>c.where, :order=>"reservations.reserved_on asc")      
  end

  def self.point_in_range(time_reserved_on, time_reserved_until, fc=nil, shop=nil, staff=nil, customer=nil)
    c = Condition.new
    c.and "reservations.reserved_on", ">=", time_reserved_on
    c.and "reservations.reserved_on", "<",  time_reserved_until
    
    c.and "reservations.franchisee_id", fc.id         unless fc.blank?
    c.and "reservations.shop_id",       shop.id       unless shop.blank?
    c.and "reservations.staff_id",      staff.id      unless staff.blank?
    c.and "reservations.customer_id",   customer.id   unless customer.blank?

    c.and "reservations.product_id IS NOT NULL", "1=1"
    
    Reservation.find(:all, :conditions=>c.where, :order=>"reservations.reserved_on asc")      
  end

  def self.varieties_of_shops(time_reserved_on, time_reserved_until, fc=nil, shop=nil, staff=nil, customer=nil)
    c = Condition.new
    c.and "reservations.reserved_on", ">=", time_reserved_on
    c.and "reservations.reserved_on", "<",  time_reserved_until
    
    c.and "reservations.franchisee_id", fc.id         unless fc.blank?
    c.and "reservations.shop_id",       shop.id       unless shop.blank?
    c.and "reservations.staff_id",      staff.id      unless staff.blank?
    c.and "reservations.customer_id",   customer.id   unless customer.blank?

    c.and "reservations.product_id IS NOT NULL", "1=1"
    
    Shop.find(:all, :conditions=>c.where, :select=>"DISTINCT shops.*", :joins=>"inner join reservations on shops.id=reservations.shop_id")      
  end

  def self.in_range_assigned(time_reserved_on, time_reserved_until, fc=nil, shop=nil)
    c = timeline_condition(time_reserved_on, time_reserved_until)
    c.and "reservations.staff_id IS NOT NULL", "AND", "1=1"
   c.and "reservations.franchisee_id", fc.id         unless fc.blank?
   c.and "reservations.shop_id",       shop.id       unless shop.blank?
         
    Reservation.find(:all, :conditions=>c.where, :order=>"reservations.reserved_on asc")      
  end

  def self.in_range_opened(time_reserved_on, time_reserved_until, fc=nil, shop=nil)
    c = timeline_condition(time_reserved_on, time_reserved_until)
    c.and "reservations.staff_id IS NULL", "AND", "1=1"
    c.and "reservations.franchisee_id", fc.id         unless fc.blank?
    c.and "reservations.shop_id",       shop.id       unless shop.blank?
         
    Reservation.find(:all, :conditions=>c.where, :order=>"reservations.reserved_on asc")      
  end

  def self.timeline_condition(time_reserved_on, time_reserved_until, busy_scope=true)
    c = Condition.new

    c.and do |cx|
      cx.or do | cx1 |
        cx1.and "reservations.reserved_on",     ">=", time_reserved_on
        cx1.and "reservations.reserved_until",  "<=", time_reserved_until
      end
      cx.or do | cx2 |
        cx2.and "reservations.reserved_until",  ((busy_scope)? ">=": ">"), time_reserved_on
        cx2.and "reservations.reserved_until",  ((busy_scope)? "<=": "<"), time_reserved_until
      end
      cx.or do | cx3 |
        cx3.and "reservations.reserved_on",     ((busy_scope)? ">=": ">"), time_reserved_on
        cx3.and "reservations.reserved_on",     ((busy_scope)? "<=": "<"), time_reserved_until
      end
      cx.or do | cx4 |
        cx4.and "reservations.reserved_on",     "<=",   time_reserved_on
        cx4.and "reservations.reserved_until",  ">=",   time_reserved_until
      end
    end
    c    
  end

  def busy?(target_date_time)
    scope_from  = target_date_time
    scope_until = target_date_time+(30*60)
    
#    p scope_from.strftime("%m-%d %H:%M")+"〜"+scope_until.strftime("%m-%d %H:%M")
    if scope_from < self.reserved_until  &&  self.reserved_until   < scope_until
#      puts "HIT-1"+" : "+" R = " + self.reserved_on.strftime("%H:%M")+"〜" + self.reserved_until.strftime("%H:%M")
      return true
    elsif scope_from <= self.reserved_on  &&  self.reserved_on      < scope_until
#      puts "HIT-2"+" : "+" R = " + self.reserved_on.strftime("%H:%M")+"〜" + self.reserved_until.strftime("%H:%M")
      return true
    elsif self.reserved_on <= scope_from  &&  scope_until           <= self.reserved_until 
#      puts "HIT-3"+" : "+" R = " + self.reserved_on.strftime("%H:%M")+"〜" + self.reserved_until.strftime("%H:%M")
      return true
    elsif scope_from < self.reserved_on  &&  self.reserved_until   < scope_until
#      puts "HIT-4"+" : "+" R = " + self.reserved_on.strftime("%H:%M")+"〜" + self.reserved_until.strftime("%H:%M")
      return true
    end

    return false
  end

  def busy_quarter?(target_date_time)
    scope_from  = target_date_time
    scope_until = target_date_time+(15*60)
    
    if scope_from < self.reserved_until  &&  self.reserved_until   < scope_until
#      p scope_from.strftime("%m-%d %H:%M")+"〜"+scope_until.strftime("%m-%d %H:%M")
#      puts "HIT-1"+" : "+" R = " + self.reserved_on.strftime("%H:%M")+"〜" + self.reserved_until.strftime("%H:%M")
      return true
    elsif scope_from <= self.reserved_on  &&  self.reserved_on      < scope_until
#      p scope_from.strftime("%m-%d %H:%M")+"〜"+scope_until.strftime("%m-%d %H:%M")
#      puts "HIT-2"+" : "+" R = " + self.reserved_on.strftime("%H:%M")+"〜" + self.reserved_until.strftime("%H:%M")
      return true
    elsif self.reserved_on <= scope_from  &&  scope_until           <= self.reserved_until 
#      p scope_from.strftime("%m-%d %H:%M")+"〜"+scope_until.strftime("%m-%d %H:%M")
#      puts "HIT-3"+" : "+" R = " + self.reserved_on.strftime("%H:%M")+"〜" + self.reserved_until.strftime("%H:%M")
      return true
    elsif scope_from < self.reserved_on  &&  self.reserved_until   < scope_until
#      p scope_from.strftime("%m-%d %H:%M")+"〜"+scope_until.strftime("%m-%d %H:%M")
#      puts "HIT-4"+" : "+" R = " + self.reserved_on.strftime("%H:%M")+"〜" + self.reserved_until.strftime("%H:%M")
      return true
    end

    return false
  end

private
  def valid_reservation?
    unless true || ALLOW_DUPLICATIVE_RESERVATION
      return true if self.staff_id.blank?
      
      c = Reservation.timeline_condition(self.reserved_on, self.reserved_until, false)
      c.and "reservations.shop_id",         self.shop_id
      c.and "reservations.staff_id",        self.staff_id
      c.and "reservations.id",        "!=", self.id         unless self.id.blank?
      dup_reservations = Reservation.find(:all, :conditions=>c.where)
      
#      p dup_reservations
      
      unless dup_reservations.blank?
        errors.add(:reserved_on, "予約時間が重複しています。")
      end
    end
  end
  
end
