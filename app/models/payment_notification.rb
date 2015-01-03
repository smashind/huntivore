class PaymentNotification < ActiveRecord::Base
  belongs_to :reservation
  serialize :params
  after_create :mark_as_paid

  private

    def mark_as_paid
    	if status == "Completed"
    		reservation.update_attributes(updated_at: Time.now, status: paid)
    		# Todo
    		# ReservationMailer.paid_email(reservation).deliver
    	end
    end
end
