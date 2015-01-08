class CreateGamings < ActiveRecord::Migration
  def change
    create_table :gamings do |t|
      t.belongs_to :game, index: true
      t.belongs_to :property, index: true

      t.timestamps
    end
  end
end
