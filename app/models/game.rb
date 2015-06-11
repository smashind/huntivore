class Game < ActiveRecord::Base
	has_many :gamings
	has_many :properties, through: :gamings, counter_cache: :properties_count

	scope :alphabetically, -> { order("name ASC") }

	def to_param
    [id, name.parameterize].join("-")
  end
end
