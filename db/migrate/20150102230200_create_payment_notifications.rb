class CreatePaymentNotifications < ActiveRecord::Migration
  def change
    create_table :payment_notifications do |t|
      t.text :params
      t.string :status
      t.string :transaction_id
      t.belongs_to :reservation, index: true

      t.timestamps
    end
  end
end
