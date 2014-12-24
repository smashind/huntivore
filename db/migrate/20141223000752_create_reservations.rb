class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.date :to
      t.date :from
      t.string :status
      t.belongs_to :user, index: true
      t.belongs_to :property, index: true

      t.timestamps
    end
  end
end
