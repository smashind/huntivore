class AddLocationToOutfitters < ActiveRecord::Migration
  def change
    add_column :outfitters, :location, :string
  end
end
