class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def trips
  	@user = User.find(params[:user_id])
  	@reservations = @user.reservations.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def hosting
  	@user = User.find(params[:user_id])
  	@hosted_trips = @user.hostings.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def favorites
  	@user = User.find(params[:user_id])
  	@favorites = @user.favorites.order(created_at: :desc).paginate(page: params[:page], per_page: 20)
  end
end
