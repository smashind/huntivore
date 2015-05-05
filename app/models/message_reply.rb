class MessageReply < ActiveRecord::Base
  belongs_to :user
  belongs_to :sent_message
end
