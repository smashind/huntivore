class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :property
  has_many :payment_notifications
  validates :from, presence: true
  validates :to, presence: true, if: :should_validate_to?
  validates :user_id, presence: true
  validates :property_id, presence: true

  validate :date_order

  def trip_price
    if to.nil? && !property.per_person
      sprintf("%.2f", (property.price + (property.price * HUNTIVORE_FEE)))
    elsif to.nil? && property.per_person
      sprintf("%.2f", (property.price * guests + ((property.price * guests) * HUNTIVORE_FEE)))
    elsif property.per_person
  	  sprintf("%.2f", (Array(from..to-1).count * property.price * guests + ((Array(from..to-1).count * property.price * guests) * HUNTIVORE_FEE)))
    else
      sprintf("%.2f", (Array(from..to-1).count * property.price + ((Array(from..to-1).count * property.price) * HUNTIVORE_FEE)))
    end
  end

  def owner_earnings
    if to.nil? && !property.per_person
      sprintf("%.2f", (property.price))
    elsif to.nil? && property.per_person
      sprintf("%.2f", (property.price * guests))
    elsif property.per_person
      sprintf("%.2f", (Array(from..to-1).count * property.price * guests))
    else
      sprintf("%.2f", (Array(from..to-1).count * property.price))
    end
  end

  def huntivore_earnings
    sprintf("%.2f", (trip_price.to_f - owner_earnings.to_f))
  end

  def self.update_statuses
    # Update pending reservations to missed
    @pending_night = where(status: "Pending").where.not(to: Date.today..Float::INFINITY)
    where(status: "Pending").where.not(to: Date.today..Float::INFINITY).update_all(status: "Missed")    
    @pending_day = where(status: "Pending", to: nil).where.not(from: Date.today..Float::INFINITY)
    where(status: "Pending", to: nil).where.not(from: Date.today..Float::INFINITY).update_all(status: "Missed")
    
    # Update paid reservations to completed
    @paid_night = where(status: "Paid").where.not(to: Date.today..Float::INFINITY)
    if @paid_night.any?
      ReservationMailer.paid_night_hunts(@paid_night).deliver
    end
    where(status: "Paid").where.not(to: Date.today..Float::INFINITY).update_all(status: "Completed")
    @paid_day = where(status: "Paid", to: nil).where.not(from: Date.today..Float::INFINITY)
    if @paid_day.any?
      ReservationMailer.paid_day_hunts(@paid_day).deliver
    end
    where(status: "Paid", to: nil).where.not(from: Date.today..Float::INFINITY).update_all(status: "Completed")
  end

  private

    def date_order
    	if self.to && (self.from > self.to)
        self.errors[:base] << "End date must come after start date."
    	end
    end

    def should_validate_to?
      if property.hunttype == 'Overnight'
        true
      end
    end
end
