# Preview all emails at http://localhost:3000/rails/mailers/inquiry_mailer
class InquiryMailerPreview < ActionMailer::Preview
    def inquiry
        inquiry = Inquiry.new(name: "侍 太郎", body: "問い合わせメッセージ")
        #.deliver_nowこれが重要
        InquiryMailer.send_mail(inquiry).deliver_now
    end
end
