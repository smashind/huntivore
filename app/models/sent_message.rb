class SentMessage < ActiveRecord::Base
  belongs_to :user
  has_many :replies, class_name: "MessageReply", foreign_key: "sent_message_id"
end
