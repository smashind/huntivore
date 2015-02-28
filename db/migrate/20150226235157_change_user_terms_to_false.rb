class ChangeUserTermsToFalse < ActiveRecord::Migration
  def change
  	change_column_default(:users, :accepted_terms, false)
  end
end
