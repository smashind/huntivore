class Game < ActiveRecord::Base
	has_many :gamings
	has_many :properties, through: :gamings

	scope :alphabetically, -> { order("name ASC") }
end
