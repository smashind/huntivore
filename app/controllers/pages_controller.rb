class PagesController < ApplicationController
	skip_before_action :verify_authenticity_token, only: :success
  def home
  	if user_signed_in?
  		redirect_to user_path(current_user)
  	end
  end

  def faq
  end

  def contact
  end

  def success
  end
end
