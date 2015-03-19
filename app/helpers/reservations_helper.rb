module ReservationsHelper
	def res_maker?
		if current_user == @reservation.user || is_admin?

			true
		end
	end

	def prop_owner?
		if current_user == @reservation.property.user || is_admin?

			true
		end
	end

	def is_admin?
		if current_user.role == "admin"
			true
		end
	end

	def can_view?
		if res_maker? || prop_owner? || is_admin?
    	true 
		end
	end

	def fee_percent(amount)
		"#{(amount * 100).to_i}%"
	end
end
