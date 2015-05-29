class AddOutfitterIdToSentMessages < ActiveRecord::Migration
  def change
    add_column :sent_messages, :outfitter_id, :integer
  end
end
