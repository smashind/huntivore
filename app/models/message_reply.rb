class MessageReply < ActiveRecord::Base
  belongs_to :user
  belongs_to :sent_message

  validates :user_id, presence: true
  validates :sent_message_id, presence: true
  validates :body, presence: true
  validates :recipient_id, presence: true
end
