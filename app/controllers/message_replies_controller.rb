class MessageRepliesController < ApplicationController
  def new
  	@message_reply = MessageReply.new
  end

  def create
  	@message_reply = current_user.message_replies.new(message_reply_params)
  	@sent_message = @message_reply.sent_message

    if @message_reply.save
      @sent_message.replied_to = true
      @sent_message.reply_date = DateTime.now
      if current_user == @sent_message.user 
        @sent_message.read_by_recipient = false
        User.increment_counter(:unread_messages, @sent_message.recipient_id)
      else
        @sent_message.read_by_user = false
        User.increment_counter(:unread_messages, @sent_message.user_id)
      end
    	@sent_message.save
      MessageMailer.reply_message(@message_reply).deliver
      redirect_back fallback_location: :root, notice: "Your reply was sent successfully!"
    else
      redirect_back fallback_location: :root, alert: "There was a problem and your reply wasn't sent."
    end
  end

  private 

    def message_reply_params
      params.require(:message_reply).permit(:user_id, :recipient_id, :body, :sent_message_id)
    end
end
