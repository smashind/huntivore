class CreateOutfitters < ActiveRecord::Migration
  def change
    create_table :outfitters do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
