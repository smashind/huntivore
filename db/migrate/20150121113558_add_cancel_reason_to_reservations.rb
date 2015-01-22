class AddCancelReasonToReservations < ActiveRecord::Migration
  def change
  	add_column :reservations, :cancel_reason, :text
  end
end
