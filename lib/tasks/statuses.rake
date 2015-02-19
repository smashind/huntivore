namespace :statuses do
  desc "Update reservation statuses from pending and paid to missed and complete"
  task update_reservations: :environment do
	  puts "Updating reservation statuses..."
	  Reservation.update_statuses
	  puts "Finished."
  end

end
