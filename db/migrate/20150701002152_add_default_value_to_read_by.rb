class AddDefaultValueToReadBy < ActiveRecord::Migration
  def change
  	change_column_default(:users, :read_by_user, false)
  	change_column_default(:users, :read_by_recipient, false)
  end
end
