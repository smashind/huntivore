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
  		redirect_to @reservation, notice: "Reservation was successfully created."
  	end
  end

  private

    def reservation_params
    	params.require(:reservation).permit(:from, :to, :user_id, :property_id)
    end
end
