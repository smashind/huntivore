class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :property
  has_many :property_attachments, through: :property
  has_many :primary_images, through: :property
end
