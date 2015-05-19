class AddPrimaryImageToPropertyAttachments < ActiveRecord::Migration
  def change
    add_column :property_attachments, :is_primary, :boolean
  end
end
