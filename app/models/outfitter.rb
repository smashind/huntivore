class Outfitter < ActiveRecord::Base
	mount_uploader :profile, ProfileUploader
	belongs_to :user

	validates :name, presence: true
	validates :location, presence: true
	validates :description, presence: true

	def to_param
    [id, name.parameterize].join("-")
  end
end
