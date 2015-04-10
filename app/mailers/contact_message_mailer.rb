class ContactMessageMailer < ActionMailer::Base
  layout 'mail'
  default from: "Huntbot <huntbot@huntivore.com>"

  def contact_us(contact_message)
    @contact_message = contact_message
    @name = contact_message.name
    @email = contact_message.email
    @message = contact_message.message
    mail(to: 'danthemanvt@gmail.com', subject: 'Huntivore contact form')
  end
end
