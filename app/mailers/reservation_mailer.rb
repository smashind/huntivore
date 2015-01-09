class ReservationMailer < ActionMailer::Base
  default from: "The Huntivore Team <support@huntivore.com>"

  def reservation_email(user, property, reservation)
  	@user = user
  	@property = property
  	@reservation = reservation
  	@owner = property.user
  	mail(to: @user.email, subject: 'Your reservation was successful!')
  end

  def owner_email(user, property, reservation)
  	@user = property.user
  	@property = property
  	@reservation = reservation
  	@resmaker = user
  	mail(to: @user.email, subject: 'Your listing was booked!')
  end

  def paid_email(reservation)
    @reservation = reservation
    @resmaker = reservation.user
    @property = reservation.property
    @user = reservation.property.user
    mail(to: @user.email, subject: 'Reservation Payment Confirmation')
  end
end