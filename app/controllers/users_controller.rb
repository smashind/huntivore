class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:trips, :hosting]
  
  def show
  	@user = User.find(params[:id])
    redirect_to_good_slug(@user) and return if bad_slug?(@user)
    @properties = @user.properties.includes(:property_attachments).includes(:primary_image)
  end

  def trips
  	@user = User.find(params[:user_id])
  	@reservations = @user.reservations.includes(:property).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def hosting
  	@user = User.find(params[:user_id])
  	@hosted_trips = @user.hostings.includes(:property).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def favorites
  	@user = User.find(params[:user_id])
  	@favorites = @user.favorites.includes(:property).includes(:property_attachments)
                 .includes(:primary_images).order(created_at: :desc).paginate(page: params[:page], per_page: 20)
  end

  def messages
    @user = User.find(params[:user_id])
    @messages = SentMessage.where(user_id: @user.id).where(replied_to: true)
                .union(SentMessage.where(recipient_id: @user.id)).includes(:user)
                .order(reply_date: :desc).paginate(page: params[:page], per_page: 10)
  end

  def outfitter_pages
    @user = User.find(params[:user_id])
    @outfitters = @user.outfitters.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end
end
