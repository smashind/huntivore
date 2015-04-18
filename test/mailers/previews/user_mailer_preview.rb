class UserPreview < ActionMailer::Preview
  # Accessible from http://localhost:3000/rails/mailers/user/welcome
  def welcome_user
    UserMailer.welcome_email(User.first)
  end

  def welcome_owner
  	UserMailer.welcome_email_owner(User.first)
  end

  def new_owner
  	UserMailer.new_owner(User.first)
  end
end