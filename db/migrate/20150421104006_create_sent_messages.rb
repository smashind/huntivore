class CreateSentMessages < ActiveRecord::Migration
  def change
    create_table :sent_messages do |t|
      t.text :body
      t.belongs_to :user, index: true
      t.integer :recipient_id, index: true
      t.integer :property_id

      t.timestamps
    end
  end
end
