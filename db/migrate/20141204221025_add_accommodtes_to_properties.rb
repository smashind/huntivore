class AddAccommodtesToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :accommodates, :integer
  end
end
