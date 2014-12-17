class Property < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :accommodates, presence: true
  validates :price, presence: true
  validates :user_id, presence: true

  has_many :property_attachments
  accepts_nested_attributes_for :property_attachments
end
