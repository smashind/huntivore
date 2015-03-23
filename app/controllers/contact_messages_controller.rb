class ContactMessagesController < ApplicationController
  def new
  	@contact_message = ContactMessage.new
  end

  def create
  	@contact_message = ContactMessage.new(contact_message_params)

  	if @contact_message.save
  		ContactMessageMailer.contact_us(@contact_message).deliver
      @contact_message.destroy
  		redirect_to contact_path, notice: "Your message was successfully sent! We will get back to you as soon as possible."
  	else
  		redirect_to contact_path, alert: "There was a problem. Your message wasn't sent."
  	end
  end

  private

    def contact_message_params
    	params.require(:contact_message).permit(:name, :email, :message)
    end
end
