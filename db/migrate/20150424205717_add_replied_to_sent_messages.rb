class AddRepliedToSentMessages < ActiveRecord::Migration
  def change
  	add_column :sent_messages, :replied_to, :boolean, default: false
  end
end
