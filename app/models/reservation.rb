class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :property
  has_many :payment_notifications
  validates :from, presence: true
  validates :to, presence: true
  validates :user_id, presence: true
  validates :property_id, presence: true

  validate :date_order

  def trip_price
  	Array(from..to-1).count * property.price
  end

  private

    def date_order
    	if self.to && (self.from > self.to)
        self.errors[:base] << "End date must come after start date."
    	end
    end
end
