class ContactMessageMailer < ActionMailer::Base
  default from: "Huntbot <huntbot@huntivore.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_message.mailer.subject
  #
  def contact_us(contact_message)
    @contact_message = contact_message
    @name = contact_message.name
    @email = contact_message.email
    @message = contact_message.message
    mail(to: 'danthemanvt@gmail.com', subject: 'Huntivore contact form')
  end
end
