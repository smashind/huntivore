class AddOutfitterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :outfitter, :boolean
  end
end
