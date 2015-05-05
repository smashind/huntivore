class AddReadByAndReplyDateToSentMessages < ActiveRecord::Migration
  def change
    add_column :sent_messages, :read_by_user, :boolean
    add_column :sent_messages, :read_by_recipient, :boolean
    add_column :sent_messages, :reply_date, :datetime
  end
end
