class AddUserIdToOutfitters < ActiveRecord::Migration
  def change
    add_reference :outfitters, :user, index: true
  end
end
