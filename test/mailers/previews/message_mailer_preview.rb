class MessageMailPreview < ActionMailer::Preview
  def new_message_mail
    MessageMailer.new_message_mail(SentMessage.last)
  end

  def reply_message
    MessageMailer.reply_message(MessageReply.last)
  end
end