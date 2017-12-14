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
        ReservationMailer.reservation_email(@reservation).deliver
        ReservationMailer.owner_email(@reservation).deliver
      #end
  		redirect_to @reservation, notice: "Reservation was successfully created."
    else
      redirect_back fallback_location: :root, alert: "Reservation not submitted. Please check your dates and try again." 
  	end
  end

  def update
    @reservation = Reservation.find(params[:id])

    if @reservation.update_attributes(reservation_params)
      ReservationMailer.cancel_email(@reservation).deliver
      redirect_to @reservation, alert: "Reservation was canceled."
    else
      redirect_to @reservation, alert: "Something went wrong and the reservation was NOT canceled."
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_back fallback_location: :root, alert: "Reservation was successfully deleted."
  end

  private

    def reservation_params
    	params.require(:reservation).permit(:from, :to, :user_id, :property_id, :status, :cancel_reason, :guests)
    end
end
