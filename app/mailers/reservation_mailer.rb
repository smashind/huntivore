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

  def cancel_email(reservation)
    @reservation = reservation
    @resmaker = reservation.user
    @property = reservation.property
    @user = reservation.property.user
    mail(to: @resmaker.email, subject: 'Your reservation was canceled')
  end

  def paid_night_hunts(paid_night)
    @paid_night = paid_night
    mail(to: 'danthemanvt@gmail.com', subject: 'Paid night hunts')
  end

  def paid_day_hunts(paid_day)
    @paid_day = paid_day
    mail(to: 'danthemanvt@gmail.com', subject: 'Paid day hunts')
  end
end