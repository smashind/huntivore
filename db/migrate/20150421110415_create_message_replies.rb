class CreateMessageReplies < ActiveRecord::Migration
  def change
    create_table :message_replies do |t|
      t.belongs_to :user, index: true
      t.belongs_to :sent_message, index: true
      t.text :body
      t.integer :recipient_id

      t.timestamps
    end
  end
end
