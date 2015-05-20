class SentMessage < ActiveRecord::Base
  belongs_to :user
  has_many :replies, class_name: "MessageReply", foreign_key: "sent_message_id"

  validates :user_id, presence: true
  validates :body, presence: true
  validates :recipient_id, presence: true
end
