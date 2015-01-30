class AddGuestsToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :guests, :integer, default: 1
  end
end
