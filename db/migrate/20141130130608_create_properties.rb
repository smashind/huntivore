class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :title
      t.text :description
      t.string :type
      t.string :location
      t.integer :price
      t.boolean :available
      t.belongs_to :user, index: true

      t.timestamps
    end
    add_index :properties, :location, unique: true
  end
end
