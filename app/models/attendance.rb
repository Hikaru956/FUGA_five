# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

#hikaru
#class Attendance < ActiveRecord::Base
class Attendance < ApplicationRecord
  belongs_to  :shop
  belongs_to  :staff

  before_save :update_min_period

  def update_min_period
    if self.start_hour > self.until_hour
      tmp = self.start_hour
      self.start_hour = self.until_hour
      self.until_hour = tmp
    end
    self.attend_period   = self.until_hour - self.start_hour 
  end

  DUTY_HOME_RESERATIONS = 0
  DUTY_AWAY_RESERATIONS = 1
  DUTY_HOME_ATTENDANCES = 2
  DUTY_AWAY_ATTENDANCES = 3

  def self.whats_going_on(probe_time, staff, home_shop, bias_min=0)
    bias_time = probe_time + (60*bias_min)
    all = Reservation.all
    crh = Reservation.timeline_condition(all, probe_time, bias_time, false)
    crh.where "reservations.staff_id",    "=", staff
    crh.where "reservations.shop_id",         "=", home_shop

    home_reservations = crh

    cra = Reservation.timeline_condition(all, probe_time, bias_time, false)
    cra.where "reservations.staff_id",    "=", staff
    cra.where "reservations.shop_id",     "!=", home_shop
    away_reservations = cra

    home_attendances = Attendance.where("   attendances.attend_on =?
                                        AND attendances.staff_id =?
                                        AND attendances.shop_id =?
                                        AND attendances.start_hour <=?
                                        AND attendances.until_hour >?", \
                                        probe_time.to_date, staff, home_shop, probe_time.hour, probe_time.hour)
    #cah = Condition.new
    #cah.and "attendances.attend_on",  probe_time.to_date
    #cah.and "attendances.staff_id",    staff
    #cah.and "attendances.shop_id",    "=", home_shop
    #cah.and "attendances.start_hour", '<=', probe_time.hour
    #cah.and "attendances.until_hour", '>',  probe_time.hour
    #home_attendances = Attendance.find(:all, :conditions=>cah.where)
    
    away_attendances = Attendance.where("   attendances.attend_on =?
                                        AND attendances.shop_id !=?
                                        AND attendances.start_hour <=?
                                        AND attendances.until_hour >?", \
                                        probe_time.to_date, home_shop, probe_time.hour, probe_time.hour)
    #caa = Condition.new
    #caa.and "attendances.attend_on",  probe_time.to_date
    #caa.and "attendances.staff_id",    "!=", home_shop
    #caa.and "attendances.start_hour", '<=', probe_time.hour
    #caa.and "attendances.until_hour", '>',  probe_time.hour
    #away_attendances = Attendance.find(:all, :conditions=>caa.where)
    
    [home_reservations, away_reservations, home_attendances, away_attendances]
  end
  
  def on_work?(target_date_time)
    leave?(target_date_time)
  end

  def leave?(target_date_time)
    probe_hour  = target_date_time.hour
    
#    puts "A(?) : " + self.start_hour.to_s + ":00" + "〜" + self.until_hour.to_s + ":00" + " For " + target_date_time.strftime("%H:%M")

    base_time = Time.mktime(self.attend_on.year, self.attend_on.month, self.attend_on.day, 0, 0, 0)
    from_time   = base_time + (self.start_hour*60*60)
    until_time  = base_time + (self.until_hour*60*60)
        
        
#    if self.start_hour <= probe_hour &&  probe_hour < self.until_hour
    if from_time <= target_date_time && target_date_time < until_time
      #     
      #                      PROBE     
      #             +----------------------+
      #             |         SELF         |
      #             +----------------------+
      #
#      puts "HIT-1"+" : "+" SCOPE = " + probe_hour.to_s + ":00 〜" + probe_hour.to_s+":59"
      return true
    end
    return false
  end


  def chop(chop_start_hour, chop_until_hour)
    if self.until_hour < chop_start_hour || self.start_hour > chop_until_hour
      ## OUT OF RANGE
      self.start_hour     = 0
      self.until_hour     = 0
      self.attend_period  = 0
    else
      self.start_hour     = chop_start_hour  if self.start_hour < chop_start_hour
      self.until_hour     = chop_until_hour  if chop_until_hour < self.until_hour
      self.attend_period  = self.until_hour - self.start_hour
    end
    self
  end

  def self.summary(attendances_map_by_day, from_date, until_date, start_business_hour, until_business_hour)
    sum_business_days   = (until_date.to_date-from_date.to_date) + 1
    sum_business_hours  = sum_business_days*(until_business_hour-start_business_hour)
    
    # Chop All
    attendances_map_by_day.values.each do |day_array|
      day_array.each do | attendance |
        attendance = attendance.chop(start_business_hour, until_business_hour)
      end
    end

    business_hours    = until_business_hour-start_business_hour
    sum_working_days  = 0
    sum_working_hours = 0
    sum_absence_days  = 0
    sum_absence_hours = 0

    for day in from_date..until_date
      day_array = attendances_map_by_day[day]
      
      if day_array.blank?
        sum_absence_days  += 1
        sum_absence_hours = sum_absence_hours+business_hours
      else
        sum_working_days  += 1  

        attend_hours = 0
        day_array.each { |a| attend_hours += a.attend_period }
        attend_hours = (attend_hours>=business_hours)? business_hours: attend_hours
        
        sum_absence_hours += (business_hours-attend_hours)
        sum_working_hours += attend_hours
      end
    end
    [sum_business_days.to_i, sum_business_hours.to_i, sum_working_days.to_i, sum_working_hours.to_i, sum_absence_days.to_i, sum_absence_hours.to_i]    
  end

end
