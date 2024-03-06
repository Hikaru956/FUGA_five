module AdminReservationHelper
    def reservation_spanner_quarter(shop, reservation, probe_date)
    # Set frame
    range_from  = Time.mktime(probe_date.year, probe_date.month, probe_date.day, shop.business_hour_from, 0, 0)    
    range_until = range_from+((shop.business_hour_until-shop.business_hour_from)*60*60)

    range_from    = range_from
    range_until   = range_until
    
    # Adjustment
    res_from  = (reservation.reserved_on<range_from)? range_from: reservation.reserved_on
    res_until = (reservation.reserved_until>range_until)? range_until: reservation.reserved_until
    
    # offset
    of_fwd_min  = res_from.min%15
    res_from    = res_from-(of_fwd_min*60)          if of_fwd_min!=0
    of_bwd_min  = res_until.min%15
    res_until   = res_until+((15-of_bwd_min)*60)    if of_bwd_min!=0
    
    # forwarding count
    cnt_fwd = ((res_from-range_from)/(60*15)).ceil
    
    # span count
    cnt_span = ((res_until-res_from)/(60*15)).ceil
    
    # backward count
    cnt_bwd = ((range_until-res_until)/(60*15)).ceil
    
#    puts "****** Fwd : " + cnt_fwd.to_s
#    puts "****** Spn : " + cnt_span.to_s
#    puts "****** Bwd : " + cnt_bwd.to_s
    
    [cnt_fwd,cnt_span,cnt_bwd]
  end

  def timeline_classes(shop, target_date, reservations, attendances, 
                              work_class="roster_work", 
                              absence_class="roster_absence", 
                              reservation_class="roster_reservation", 
                              reservation_warning_class="roster_reservation_warning")
                              
    array_size = ((shop.business_hour_until<24)? 24: shop.shop.business_hour_until)                         

    roster_td_classes = []
    for hh in 0..(array_size*4)
      roster_td_classes << absence_class
    end
    
    probe_date = Time.mktime(target_date.year, target_date.month, target_date.day, 0,0,0)
    unless reservations.blank?
      reservations.each do | r |
        
        ###
        ##  Perf
        #
        #counter = Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }
        #for hh in 0..(array_size)
        #  roster_td_classes[hh*4]    = reservation_warning_class if r.busy_quarter?(probe_date+(hh*60*60))
        #  roster_td_classes[hh*4+1]  = reservation_warning_class if r.busy_quarter?(probe_date+(hh*60*60+15*60))
        #  roster_td_classes[hh*4+2]  = reservation_warning_class if r.busy_quarter?(probe_date+(hh*60*60+30*60))
        #  roster_td_classes[hh*4+3]  = reservation_warning_class if r.busy_quarter?(probe_date+(hh*60*60+45*60))
        #end
        #puts "#*12"+" : "+ (Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }-counter).to_s
        
        #counter = Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }
        index_from  = (r.reserved_on.hour)*4+(r.reserved_on.min/15)
        index_until = (r.reserved_until.hour)*4+(r.reserved_until.min/15)
        roster_td_classes.fill(reservation_warning_class,index_from,index_until-index_from)
        #puts "$"*12+" : ["+ index_from.to_s + " .. ["+index_until.to_s+"] " + (Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }-counter).to_s
      end
    end
    
    unless attendances.blank?
      attendances.each do | a |
        ###
        ##  Perf
        #
        #counter = Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }
        #for hh in 0..(array_size)
        #  roster_td_classes[hh*4]   = ((roster_td_classes[hh*4]  ==reservation_warning_class)? reservation_class: work_class)  if a.on_work?(probe_date+(hh*60*60))
        #  roster_td_classes[hh*4+1] = ((roster_td_classes[hh*4+1]==reservation_warning_class)? reservation_class: work_class)  if a.on_work?(probe_date+(hh*60*60+15*60))
        #  roster_td_classes[hh*4+2] = ((roster_td_classes[hh*4+2]==reservation_warning_class)? reservation_class: work_class)  if a.on_work?(probe_date+(hh*60*60+30*60))
        #  roster_td_classes[hh*4+3] = ((roster_td_classes[hh*4+3]==reservation_warning_class)? reservation_class: work_class)  if a.on_work?(probe_date+(hh*60*60+45*60))
        #end
        #puts "#*12"+" : "+ (Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }-counter).to_s

        #counter = Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }
        index_from  = (a.start_hour)*4
        index_until = (a.until_hour)*4
        for ah in index_from..(index_until-1)
          roster_td_classes[ah] = ((roster_td_classes[ah]==reservation_warning_class)? reservation_class: work_class) 
        end
        #puts "$"*12+" : ["+ index_from.to_s + " .. "+index_until.to_s+"] " + (Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }-counter).to_s
      end
    end
    roster_td_classes
  end

  
  def reservation_line_classes(shop, target_date, reservation, attendances, 
                              work_class="roster_work", 
                              absence_class="roster_absence", 
                              reservation_class="roster_reservation", 
                              reservation_warning_class="roster_reservation_warning")
                              
    array_size = ((shop.business_hour_until<24)? 24: shop.business_hour_until)                         

    roster_td_classes = []
    for hh in 0..(array_size*4)
      roster_td_classes << absence_class
    end
    
    probe_date = Time.mktime(target_date.year, target_date.month, target_date.day, 0,0,0)
    unless attendances.blank?
      attendances.each do | a |
        ###
        ##  Perf
        #
        #counter = Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }
        #for hh in 0..(array_size)
        #  roster_td_classes[hh*4]   = work_class  if a.on_work?(probe_date+(hh*60*60))
        #  roster_td_classes[hh*4+1] = work_class  if a.on_work?(probe_date+(hh*60*60+15*60))
        #  roster_td_classes[hh*4+2] = work_class  if a.on_work?(probe_date+(hh*60*60+30*60))
        #  roster_td_classes[hh*4+3] = work_class  if a.on_work?(probe_date+(hh*60*60+45*60))
        #end
        #puts "#"*12+" : "+ (Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }-counter).to_s
        
        #counter = Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }
        index_from  = (a.start_hour)*4
        index_until = (a.until_hour)*4
        roster_td_classes.fill(work_class,index_from,index_until-index_from)
        #puts "$*12"+" : ["+ index_from.to_s + " .. "+index_until.to_s+"] " + (Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }-counter).to_s
      end
    end

    ###
    ##  Perf
    #
    #counter = Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }
    #for hh in 0..(array_size)
    #  roster_td_classes[hh*4]    = ((roster_td_classes[hh*4]    == work_class)? reservation_class: reservation_warning_class)   if reservation.busy_quarter?(probe_date+(hh*60*60))
    #  roster_td_classes[hh*4+1]  = ((roster_td_classes[hh*4+1]  == work_class)? reservation_class: reservation_warning_class)   if reservation.busy_quarter?(probe_date+(hh*60*60+15*60))
    #  roster_td_classes[hh*4+2]  = ((roster_td_classes[hh*4+2]  == work_class)? reservation_class: reservation_warning_class)   if reservation.busy_quarter?(probe_date+(hh*60*60+30*60))
    #  roster_td_classes[hh*4+3]  = ((roster_td_classes[hh*4+3]  == work_class)? reservation_class: reservation_warning_class)   if reservation.busy_quarter?(probe_date+(hh*60*60+45*60))
    #end
    #puts "#"*12+" : "+ (Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }-counter).to_s
    
    #counter = Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }
    index_from  = (reservation.reserved_on.hour)*4+(reservation.reserved_on.min/15)
    index_until = (reservation.reserved_until.hour)*4+(reservation.reserved_until.min/15)
    for ah in index_from..(index_until-1)
      #logger.debug reservation.reserved_on.hour
      #logger.debug roster_td_classes[ah]
      #logger.debug roster_td_classes[ah]==work_class
      #logger.debug ah
      roster_td_classes[ah] = ((roster_td_classes[ah]==work_class)? reservation_class: reservation_warning_class) 
      #logger.debug roster_td_classes[ah]
    end
    #puts "$"*12+" : ["+ index_from.to_s + " .. "+index_until.to_s+"] " + (Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }-counter).to_s
    roster_td_classes
  end

  def roster_timeline_classes(shop, target_date, reservations, attendances, 
                              work_class="roster_work", 
                              absence_class="roster_absence", 
                              reservation_class="roster_reservation", 
                              reservation_warning_class="roster_reservation_warning")

    array_size = ((shop.business_hour_until<24)? 24: shop.business_hour_until)
    roster_td_classes = []
    for hh in 0..(array_size*2)
      roster_td_classes << absence_class
    end

    probe_date = Time.mktime(target_date.year, target_date.month, target_date.day, 0,0,0)
    unless reservations.blank?
      reservations.each do | r |
        ###
        ##  Perf
        #
        #counter = Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }
        #for hh in 0..(array_size)
        #  roster_td_classes[hh*2]    = reservation_warning_class if r.busy?(probe_date+(hh*60*60))
        #  roster_td_classes[hh*2+1]  = reservation_warning_class if r.busy?(probe_date+(hh*60*60+30*60))
        #end
        #puts "#"*12+" : "+ (Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }-counter).to_s

        #counter = Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }
        index_from  = (r.reserved_on.hour)*2    + ((r.reserved_on.min>=30)? 1:0)
        index_until = (r.reserved_until.hour)*2 + ((r.reserved_until.min>=30)? 1:0)
        roster_td_classes.fill(reservation_warning_class,index_from,index_until-index_from)
        #puts "$"*12+" : ["+ index_from.to_s + " .. "+index_until.to_s+"] " + (Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }-counter).to_s
      end
    end

    unless attendances.blank?
      attendances.each do | a |
        ###
        ##  Perf
        #
        #counter = Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }
        #for hh in 0..(array_size)
        #  if a.on_work?(probe_date+(hh*60*60))
        #    roster_td_classes[hh*2]   = (roster_td_classes[hh*2]    ==  reservation_warning_class)?   reservation_class: work_class
        #    roster_td_classes[hh*2+1] = (roster_td_classes[hh*2+1]  ==  reservation_warning_class)?   reservation_class: work_class
        #  end  
        #end
        #puts "#"*12+" : "+ (Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }-counter).to_s
        
        #counter = Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }
        index_from  = (a.start_hour)*2
        index_until = (a.until_hour)*2
        for ah in index_from..(index_until-1)
          roster_td_classes[ah] = ((roster_td_classes[ah]==reservation_warning_class)? reservation_class: work_class) 
        end
        #puts "$"*12+" : ["+ index_from.to_s + " .. "+index_until.to_s+"] " + (Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }-counter).to_s
      end
    end
    roster_td_classes
  end
  
end
