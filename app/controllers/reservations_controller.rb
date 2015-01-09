class ReservationsController < ApplicationController

  def show
  	@reservation = Reservation.find(params[:id])
  end

  def new
  	@reservation = Reservation.new
  end

  def create
  	@reservation = current_user.reservations.new(reservation_params)

  	if @reservation.save
      if Rails.env.production?
        user = User.find(params[:reservation][:user_id])
        property = Property.find(params[:reservation][:property_id])
        ReservationMailer.reservation_email(user, property, @reservation).deliver
        ReservationMailer.owner_email(user, property, @reservation).deliver
      end
  		redirect_to @reservation, notice: "Reservation was successfully created."
    else
      redirect_to :back, alert: "Reservation not submitted. Please check your dates and try again." 
  	end
  end

  private

    def reservation_params
    	params.require(:reservation).permit(:from, :to, :user_id, :property_id)
    end
end
