class ReservationsController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
  	@reservation = Reservation.find(params[:id])
  end

  def new
  	@reservation = Reservation.new
  end

  def create
  	@reservation = current_user.reservations.new(reservation_params)

  	if @reservation.save
      #if Rails.env.production?
        ReservationMailer.reservation_email(@reservation.user, @reservation.property, @reservation).deliver
        ReservationMailer.owner_email(@reservation.user, @reservation.property, @reservation).deliver
      #end
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
