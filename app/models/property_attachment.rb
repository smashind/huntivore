class PropertyAttachment < ActiveRecord::Base
	mount_uploader :image, ImageUploader
  belongs_to :property

  scope :primary, -> { where(is_primary: true) }

  before_save :clear_primary, if: Proc.new { |r| (r.is_primary_changed? && r.is_primary) }

  def clear_primary
  	PropertyAttachment.where(property_id: self.property_id).update_all(is_primary: false)
  end
end
