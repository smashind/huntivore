class Outfitter < ActiveRecord::Base
	mount_uploader :profile, ProfileUploader
	belongs_to :user

	validates :name, presence: true
	validates :location, presence: true
	validates :description, presence: true
end
