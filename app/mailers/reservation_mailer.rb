class ReservationMailer < ActionMailer::Base
  layout 'mail'
  default from: "The Huntivore Team <support@huntivore.com>"

  def reservation_email(reservation)
    @reservation = reservation
    @user = reservation.user
    @property = reservation.property 
    @owner = reservation.property.user 
  	mail(to: @user.email, subject: 'Your reservation was successful!')
  end

  def owner_email(reservation)
    @reservation = reservation
    @user = reservation.property.user
    @property = reservation.property
    @resmaker = reservation.user
  	mail(to: @user.email, subject: "#{@property.title} was booked!")
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