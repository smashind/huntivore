class CreatePropertyAttachments < ActiveRecord::Migration
  def change
    create_table :property_attachments do |t|
      t.belongs_to :property, index: true
      t.string :image

      t.timestamps
    end
  end
end
