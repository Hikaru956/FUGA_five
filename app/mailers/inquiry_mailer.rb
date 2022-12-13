class InquiryMailer < ApplicationMailer
    def send_mail(inquiry)
        @inquiry = inquiry
        shop = @inquiry.shop
        mail(
        from: ENV['TACHIKAWA_EMAIL_ADDRESS'],
        to:   shop.wsite_email,
        subject: '[swifty] お問い合わせ通知'
        )
    end
end
