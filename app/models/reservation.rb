class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :property
  validates :from, presence: true
  validates :to, presence: true

  validate :date_order

  private

    def date_order
    	if self.to && (self.from > self.to)
        self.errors[:base] << "End date must come after start date."
    	end
    end
end
