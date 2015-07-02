class ChangeDefaultValueOfSentMessages < ActiveRecord::Migration
  def change
  	change_column_default(:users, :read_by_user, true)
  end
end
