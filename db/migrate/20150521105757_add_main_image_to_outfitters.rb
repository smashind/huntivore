class AddMainImageToOutfitters < ActiveRecord::Migration
  def change
    add_column :outfitters, :profile, :string
  end
end
