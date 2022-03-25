module BsContentInquiryHelper
    def inquiry_status_label(status)
        return "未処理" if status==Inquiry::INQ_OPEN
        return "処理中" if status==Inquiry::INQ_WORKING
        return "処理済" if status==Inquiry::INQ_CLOSE

        return "不明"
    end

    def inquiry_status_color(status)
        return 'warning' if status==Inquiry::INQ_OPEN
        return 'info'    if status==Inquiry::INQ_WORKING
        return ''        if status==Inquiry::INQ_CLOSE

        return "error"
    end
end
