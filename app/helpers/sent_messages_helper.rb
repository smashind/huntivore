module SentMessagesHelper
	def unread_messages user
		unread_by_user(user) + unread_by_recipient(user)
	end

	def unread_by_user user
		unread_messages = 0
		user.sent_messages.each do |message| 
			if !message.read_by_user
				unread_messages += 1
			end
		end
		unread_messages
	end

	def unread_by_recipient user
		unread_total = 0
		user.messages.each do |message| 
			if !message.read_by_recipient
				unread_total += 1
			end
		end
		unread_total
	end
end
