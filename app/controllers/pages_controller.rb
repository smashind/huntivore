class PagesController < ApplicationController
	skip_before_action :verify_authenticity_token, only: :success
  layout 'listing', only: :listing
  before_action :redirect_signed_in, only: [:home, :list, :special, :listing]
  
  def home
  end

  def list
  end

  def special
  end

  def listing

  end

  def faq
  end

  def contact
  end

  def terms
  end

  def about
  end
  
  def success
  end

  private

    def redirect_signed_in
      if user_signed_in?
        redirect_to user_path(current_user)
      end
    end
end
