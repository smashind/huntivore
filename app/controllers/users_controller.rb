class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def trips
  	@user = User.find(params[:user_id])
  	@reservations = @user.reservations.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end

  def hosting
  	@user = User.find(params[:user_id])
  	@hosted_trips = @user.hostings.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end
end
