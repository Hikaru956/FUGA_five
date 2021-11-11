# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

class BsAttendanceController < ApplicationController
  before_action :authenticate_user!
  before_action :session_operation

  layout  "fuga"

  ###
  ##  Attendance
  #
  def index
    @shop = current_user.shop
    @target_date = (params[:year].blank?)?  Time.mktime(Time.now.to_date.year, 1,1,0,0,0).to_date: Time.mktime(params[:year], 1,1,0,0,0).to_date
  end

  def attendances_staff
    @shop = current_user.shop
    @staff  = Staff.find(params[:id])
    @target_date = (params[:year].blank?||params[:month].blank?)? Time.now.to_date: Time.mktime(params[:year], params[:month],1,0,0,0).to_date

    @my_reservations = @shop.reservations.where("     reservations.shop_id =?
                                                  AND reservations.reserved_on >=?
                                                  AND reservations.reserved_on <?", \
                                                  @shop.id, @target_date, @target_date>>1)
    @reservation_map = @my_reservations.group_by{|r| r.reserved_on.to_date }
    #cr = Condition.new
    #cr.and "reservations.shop_id", @shop.id
    #cr.and "reservations.reserved_on", ">=", @target_date
    #cr.and "reservations.reserved_on", "<",  @target_date>>1
    #@my_reservations  = @staff.reservations.find(:all, :conditions=>cr.where)
    #@reservation_map  = @my_reservations.group_by{|r| r.reserved_on.to_date }

    @roster_map = @staff.attendances.where("    attendances.attend_on >=? 
                                            AND attendances.attend_on <?
                                            AND attendances.shop_id =?", \
                                            @target_date, @target_date>>1, @shop.id)
    @roster_map = @roster_map.group_by{|a| a.attend_on }
    #ca = Condition.new
    #ca.and "attendances.attend_on", ">=", @target_date
    #ca.and "attendances.attend_on", "<",  @target_date>>1
    #ca.and "attendances.shop_id", @shop.id
    #@roster_map = @staff.attendances.find(:all, :conditions=>ca.where).group_by{|a| a.attend_on }


#    @bc_work_until  = Time.mktime(@target_date.year, @target_date.month, BC_WORK_DAY,0,0,0).to_date
#    @bc_work_from   = (@bc_work_until<<1)+1

    @bc_work_from   = @target_date # Shop.bc_month_range_from(@target_date, 1)
    @bc_work_until  = (@target_date>>1)-1 # (@bc_work_from.to_date>>1)
    
    @shop_roster_map = @staff.attendances.where("   attendances.attend_on >=?
                                                AND attendances.attend_on <=?", \
                                                @bc_work_from.to_date, @bc_work_until.to_date)
    @shop_roster_map = @shop_roster_map.group_by{|a| a.attend_on }
    @summary_array = Attendance.summary(@shop_roster_map, @bc_work_from.to_date, @bc_work_until.to_date, @shop.business_hour_from, @shop.business_hour_until)

    #cd = Condition.new
    #cd.and "attendances.attend_on", ">=",   @bc_work_from.to_date
    #cd.and "attendances.attend_on", "<=",    @bc_work_until.to_date
    #@shop_roster_map = @staff.attendances.find(:all, :conditions=>cd.where).group_by{|a| a.attend_on }
    #@summary_array = Attendance.summary(@shop_roster_map, @bc_work_from.to_date, @bc_work_until.to_date, @shop.business_hour_from, @shop.business_hour_until)
  end

  def init_roster
    @shop   = current_user.shop
    @staff  = @shop.staffs.find(params[:id])
    @target_date = parse_date(params[:target_date])

    from_date   = parse_date(params[:from_date])
    until_date  = parse_date(params[:until_date])

    puts "#"*20
    puts from_date
    puts until_date


    # clear all attendances record in specified period
    items = Attendance.where("    attendances.shop_id =?
                              AND attendances.staff_id =?
                              AND attendances.attend_on >=?
                              AND attendances.attend_on <=?", \
                            @shop.id, @staff.id, from_date, until_date)
    items.destroy_all unless items.blank?
    #c = Condition.new
    #c.and "attendances.shop_id", @shop.id
    #c.and "attendances.staff_id", @staff.id
    #c.and "attendances.attend_on", ">=", from_date
    #c.and "attendances.attend_on", "<=", until_date
    #Attendance.destroy_all(c.where)

    # setup roster
    for d in from_date..until_date
      attendance = Attendance.new
      attendance.shop   = @shop
      attendance.staff   = @staff
      attendance.attend_on = d
      attendance.start_hour = params[:work_from]
      attendance.until_hour = params[:work_until]
      attendance.save
    end

    # setup holiday
    unless params[:holidays].blank?
      for d in from_date..until_date
        if params[:holidays].index(d.wday.to_s)
          items = Attendance.where("    attendances.shop_id =?
                                    AND attendances.staff_id =?
                                    AND attendances.attend_on =?", \
                                    @shop.id, @staff.id, d)
          items.destroy_all unless items.blank?
          #c = Condition.new
          #c.and "attendances.shop_id", @shop.id
          #c.and "attendances.staff_id", @staff.id
          #c.and "attendances.attend_on", d
          #Attendance.destroy_all(c.where)
        end
      end
    end
    redirect_to :action=>"attendances_staff", :id=>@staff, :shop_id=>@shop, :year=>@target_date.year, :month=>@target_date.month
  end

  def day_on
    @shop   = current_user.shop
    @staff  = @shop.staffs.find_by_id(params[:id])
    unless @staff.blank?
      @target_date = parse_date(params[:target_date])
      items = Attendance.where("    attendances.staff_id =?
                                AND attendances.attend_on =?", \
                               @staff.id, @target_date)
      items.destroy_all unless items.blank?
      #c = Condition.new
      #c.and "attendances.staff_id", @staff.id
      #c.and "attendances.attend_on", @target_date
      #Attendance.destroy_all(c.where)

      attend = Attendance.new
      attend.staff = @staff
      attend.shop  = @shop
      attend.attend_on = @target_date
      attend.start_hour = @shop.business_hour_from
      attend.until_hour = @shop.business_hour_until
      attend.save
    end
    redirect_to :action=>"attendances_staff", :id=>@staff, :shop_id=>@shop, :year=>@target_date.year, :month=>@target_date.month
  end

  def day_off
    @shop   = current_user.shop
    @staff  = @shop.staffs.find_by_id(params[:id])
    unless @staff.blank?
      @target_date = parse_date(params[:target_date])
      items = Attendance.where("    attendances.staff_id =?
                                AND attendances.attend_on =?", \
                               @staff.id, @target_date)
      items.destroy_all unless items.blank?
      #c = Condition.new
      #c.and "attendances.staff_id", @staff.id
      #c.and "attendances.attend_on", @target_date
      #Attendance.destroy_all(c.where)
    end
    redirect_to :action=>"attendances_staff", :id=>@staff, :shop_id=>@shop, :year=>@target_date.year, :month=>@target_date.month
  end

  def edit_business
    @shop   = current_user.shop
    @staff  = @shop.staffs.find_by_id(params[:id])
    @target_date = parse_date(params[:target_date])
  end

  def update_business
      @shop   = current_user.shop
      @staff  = @shop.staffs.find_by_id(params[:id])
      unless @staff.blank?
        @target_date = parse_date(params[:target_date])
        # clear_first
        items = Attendance.where("      attendances.shop_id =?
                            AND attendances.staff_id =?
                            AND attendances.attend_on =?", \
                            @shop.id, @staff.id, @target_date)
        items.destroy_all unless items.blank?
        #c = Condition.new
        #c.and "attendances.shop_id",  @shop.id
        #c.and "attendances.staff_id",  @staff.id
        #c.and "attendances.attend_on", "=", @target_date
        #Attendance.destroy_all(c.where)

        on_hour_array = params[:work_hour]
        unless on_hour_array.blank? || on_hour_array.empty?
          on_hour_array.sort!

          base_array = []
          for hh in 0..((@shop.business_hour_until<24)? 24: @shop.business_hour_until)
            base_array << 0
          end
          on_hour_array.each { | work_hour | base_array[work_hour.to_i] = 1 }

  #        for hh in 0..((@shop.reservation_range_until<24)? 24: @shop.reservation_range_until)
  #          puts hh.to_s+":00 =>"+base_array[hh].to_s
  #        end

          attendance_req = nil
          for hh in 0..((@shop.business_hour_until<24)? 24: @shop.business_hour_until)
            if base_array[hh]==1 && attendance_req.blank?
              attendance_req = Attendance.new
              attendance_req.shop         = @shop
              attendance_req.staff         = @staff
              attendance_req.attend_on    = @target_date
              attendance_req.start_hour   = hh
              next
            end

            if base_array[hh]==0 && !attendance_req.blank?
              attendance_req.until_hour  = hh
              attendance_req.save
              attendance_req = nil
            end
          end
          unless attendance_req.blank?
            absence_req.until_hour  = (@shop.business_hour_until<24)? 24: business_hour_until
            absence_req.save
          end
        end
      end
      redirect_to :action=>"attendances_staff", :id=>@staff, :year=>@target_date.year, :month=>@target_date.month

  end

  protected
  def session_operation
    @shop = current_user.shop
  end

end
