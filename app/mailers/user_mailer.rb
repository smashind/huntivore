class UserMailer < ActionMailer::Base
	layout 'mail'
  default from: "The Huntivore Team <support@huntivore.com>"

  def welcome_email(user)
  	@user = user 
    mail(to: @user.email, subject: "Welcome to Huntivore!")
  end

  def welcome_email_owner(user)
  	@user = user 
    mail(to: @user.email, subject: "Welcome to Huntivore!")
  end

  def new_owner(user)
  	@user = user 
    mail(to: "danthemanvt@gmail.com", subject: "New owner signup")
  end
end
