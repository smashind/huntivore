class ChangePropertyAvailabilityToTrue < ActiveRecord::Migration
  def change
  	change_column_default(:properties, :available, true)
  end
end
