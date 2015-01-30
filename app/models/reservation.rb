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
      property.price
    elsif to.nil? && property.per_person
      property.price * guests
    elsif property.per_person
  	  Array(from..to-1).count * property.price * guests
    else
      Array(from..to-1).count * property.price
    end
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
