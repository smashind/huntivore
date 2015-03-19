class AdminController < ApplicationController
  def index
  	@users = User.all
  	@properties = Property.all 
  	@reservations = Reservation.all 
  end

  def users
  	@users = User.all.order(created_at: :desc).paginate(page: params[:page], per_page: 15)
  end

  def properties
  	@properties = Property.all.order(created_at: :desc).paginate(page: params[:page], per_page: 15)
  end

  def reservations
  	@reservations = Reservation.all.order(created_at: :desc).paginate(page: params[:page], per_page: 15)
  end
end
