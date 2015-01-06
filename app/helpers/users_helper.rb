module UsersHelper
	def gravatar_for(user, options = {})
		size = options[:size] || 110
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		image_tag(gravatar_url, alt: user.full_name)
	end

	def is_owner? user
		if user_signed_in? && current_user == user
			true
		else
			false
		end
	end

	def has_properties? user
		if user.properties.any?
			true
		else
			"<h4>You don't have any properties listed.</h4>"
		end
	end

end
