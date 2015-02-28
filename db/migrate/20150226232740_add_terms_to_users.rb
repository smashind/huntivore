class AddTermsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :accepted_terms, :boolean, default: true
  end
end
