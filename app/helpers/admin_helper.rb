module AdminHelper
    def editor_six_icon(title='リッチテキストエディター',icon_size='');    sprintf("<i class='fa-regular fa-newspaper %s' title=%s></i>", icon_size, title).html_safe; end
    def attendance_six_icon(title='勤怠管理'); sprintf('<i class="fa-solid fa-calendar-days" title=%s></i>', title).html_safe; end
    def reservation_six_icon(title='予約'); sprintf('<i class="fa-solid fa-calendar-check" title=%s></i>', title).html_safe; end

    def move_to_top_icon(enable=true)
        (enable)?   '◀◀': '◁◁'
    end

    def move_to_bottom_icon(enable=true)
        (enable)?   '▶▶': '▷▷'
    end

    def move_to_higher_icon(enable=true)
        (enable)?   '◀': '◁'
    end

    def move_to_lower_icon(enable=true)
        (enable)?   '▶': '▷'
    end

end
