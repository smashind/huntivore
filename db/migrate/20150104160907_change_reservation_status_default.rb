class ChangeReservationStatusDefault < ActiveRecord::Migration
  def change
  	change_column_default(:reservations, :status, 'Pending')
  end
end
