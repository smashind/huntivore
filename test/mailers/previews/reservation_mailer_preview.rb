class ReservationMailsPreview < ActionMailer::Preview
  def reservation_email
    ReservationMailer.reservation_email(Reservation.first)
  end

  def owner_email
  	ReservationMailer.owner_email(Reservation.first)
  end

  def paid_email
  	ReservationMailer.paid_email(Reservation.first)
  end

  def cancel_email
    ReservationMailer.cancel_email(Reservation.first)
  end
end