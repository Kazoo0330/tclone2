class ContactMailer < ApplicationMailer
  default from: 'from@example.com'
  layout 'mailer'

  def contact_mail(contact)
    @contact = contact 

	mail to: "kazuki_saito@diveintocode.jp", subject: "問い合わせ確認mail"
  end 
end
