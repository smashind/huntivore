class SentMessagesController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @sent_message = SentMessage.find(params[:id])
  end

  def new
    @sent_message = SentMessage.new
  end

  def create
    @sent_message = current_user.sent_messages.new(sent_message_params)

    if @sent_message.save
      MessageMailer.new_message_mail(@sent_message).deliver
      #change recipient's unread messages count (up)
      User.increment_counter(:unread_messages, @sent_message.recipient_id)
      redirect_to :back, notice: "Your message was sent successfully!"
    else
      redirect_to :back, alert: "There was a problem and your message wasn't sent."
    end
  end

  def update
    @sent_message = SentMessage.find(params[:id])
    if current_user == @sent_message.user && @sent_message.read_by_user != true
      @sent_message.read_by_user = true
      #change user's unread messages count (down)
      User.decrement_counter(:unread_messages, current_user.id)
    elsif current_user == User.find(@sent_message.recipient_id) && @sent_message.read_by_recipient != true
      @sent_message.read_by_recipient = true
      #change user's unread messages count (down)
      User.decrement_counter(:unread_messages, @sent_message.recipient_id)
    end
    @sent_message.save
    render action: "show"
  end

  private 

    def sent_message_params
      params.require(:sent_message).permit(:user_id, :recipient_id, :body, :property_id, :outfitter_id, :read_by_user, :read_by_recipient, :reply_date)
    end
end
