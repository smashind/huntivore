module OutfittersHelper
	def is_outfitter_owner? user
		if user_signed_in? && current_user == user 
		  true
		else
			false
		end
	end
end
