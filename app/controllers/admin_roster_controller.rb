class AdminRosterController < ApplicationController
  before_action :authenticate_user!
  before_action :session_operation

  layout  "fuga5"

  helper  :calendar

  def index
    @target_date = parse_date(params[:target_date]) unless params[:target_date].blank?
    if @target_date.blank?
      now = Time.now
      @target_date = Time.mktime(now.year, now.month, 1).to_date
    end
  end

  def update_rosters
    staff_rosters = params[:rosters]
    unless staff_rosters.blank?
      staff_rosters.each_pair do | staff_id, roster_sets | 
        ###
        ##  Caution : Need to adapt the target id User Or Staff
        #
        staff = @shop.staffs.find_by_id(staff_id)
        next if staff.blank?
        roster_sets.each_pair do | date_string, roster_id |
          probe_date = parse_date(date_string) 
          next if roster_id.blank?
          
          # Destroy all current attendances
          #c = Condition.new
          ##  Caution : Need to adapt the target id User Or Staff
          #c.and "attendances.staff_id",  staff
          #c.and "attendances.attend_on", "=", probe_date
          #Attendance.destroy_all(c.where)
          item = Attendance.where("    attendances.staff_id =?
                            AND attendances.attend_on =?", \
                            staff, probe_date)
          item.destroy_all unless item.blank?
          
          roster_label = (roster_id.blank?)? nil: RosterLabel.find_by_id(roster_id)
          logger.debug 'roster_id ='+roster_id
          next if roster_label.blank?
          
          new_roster = Attendance.new
          new_roster.attend_on  = probe_date
          new_roster.staff      = staff
          new_roster.shop       = roster_label.shop
          new_roster.start_hour = roster_label.start_hour
          new_roster.until_hour = roster_label.until_hour
          new_roster.save          
        end
      end
    end
    redirect_to :action=>"index"
  end

  def list
    #@items = RosterLabel.find(:all, :order=>'position asc')
    @items = RosterLabel.order(position: :asc)
  end

  def create
    item = RosterLabel.new(roster_labels_params)
    item.save
    redirect_to :action=>"show", :id=>item
  end

  def show
    @item = RosterLabel.find(params[:id])
  end

  def update
    @item = RosterLabel.find(params[:id])
    @item.update_attributes(roster_labels_params)
    redirect_to :action=>"show", :id=>@item
  end

  def delete
    item = RosterLabel.find(params[:id])
    item.destroy
    redirect_to :action=>"list"
  end


  def move_higher
    item = RosterLabel.find(params[:id])
    item.move_higher
    redirect_to :action => "list"
  end

  def move_lower
    item = RosterLabel.find(params[:id])
    item.move_lower
    redirect_to :action => "list"
  end

protected
  def session_operation
    @shop = current_user.shop
  end

  def roster_labels_params
    params.require(:roster_label).permit(:id, :shop_id, :name, :start_hour, :until_hour, :position)
  end
end
