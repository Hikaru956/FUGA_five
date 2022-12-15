class InquiryMailer < ApplicationMailer
    def send_mail(inquiry)
        @inquiry = inquiry
        shop = @inquiry.shop
        email = return_email(shop)
        mail(
        from: ENV['TACHIKAWA_EMAIL_ADDRESS'],
        to:   email,
        subject: '[swifty] お問い合わせ通知'
        )
    end

    def return_email(shop)
        email = shop.inquiry_email || shop.wsite_email
    end

end
