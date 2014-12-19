class AddFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :facebook,  :string
  	add_column :users, :twitter,   :string
  	add_column :users, :website,   :string
  	add_column :users, :instagram, :string
  end
end
