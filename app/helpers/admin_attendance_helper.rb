module AdminAttendanceHelper

    def calendar_mark_icon(title=calendar_mark_title); sprintf("<i class='fa-regular fa-calendar-check fa-fw' title=%s></i>", title).html_safe; end
    def calendar_mark_title; 'カレンダー・マーク'; end

    def calendar_mark_type(mark_type, show_none=false)
        case mark_type
        when CalendarMark::TYPE_NONE
            return (show_none)? '(非表示)': ''
        when CalendarMark::TYPE_CIRCLE
            return "<span style='color: #00F;'>◎</span>".html_safe
        when CalendarMark::TYPE_TRIANGLE
            return "<span style='color: #F00;'>△</span>".html_safe
        when CalendarMark::TYPE_BATSU
            return "<span style='color: #AAA;'>X</span>".html_safe
        end
        return ''
    end

    def calendar_mark_on(target_date, staff)
        cm = staff.calendar_marks.find_by(target_date: target_date)
        (cm.blank? || cm.mark_type==CalendarMark::TYPE_NONE)? nil: calendar_mark_type(cm.mark_type)
    end

end
