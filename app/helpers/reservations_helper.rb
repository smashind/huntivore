module ReservationsHelper
	def res_maker?
		if current_user == @reservation.user
			true
		end
	end

	def prop_owner?
		if current_user == @reservation.property.user 
			true
		end
	end

	def can_view?
		if res_maker? || prop_owner? 
    	true 
		end
	end
end
