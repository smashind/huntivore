class MessageMailer < ActionMailer::Base
	layout 'mail'
  default from: "HuntBot <do-not-reply@huntivore.com>"

  def new_message_mail(sent_message)
  	@sent_message = sent_message
  	@sender = sent_message.user
  	@recipient = User.find(sent_message.recipient_id)
  	@message = sent_message.body
  	if sent_message.property_id?
  		@property = Property.find(sent_message.property_id)
  		mail(to: @recipient.email, subject: "You have a new message regarding #{@property.title}!")
  	elsif sent_message.outfitter_id?
  	  @outfitter = Outfitter.find(sent_message.outfitter_id)
  	  mail(to: @recipient.email, subject: "You have a new message regarding #{@outfitter.name}!")
  	else
  		mail(to: @recipient.email, subject: "You have a new message from #{@sender.full_name}!")
  	end
  end

  def reply_message(reply)
    @reply = reply.body
    @sender = reply.user 
    @recipient = User.find(reply.recipient_id)
    @sent_message = reply.sent_message
    mail(to: @recipient.email, subject: "#{@sender.first_name} replied to your message!")
  end
end
