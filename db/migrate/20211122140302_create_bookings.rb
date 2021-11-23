class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.integer :chair_id
      t.integer :service_id
      t.integer :customer_id

      t.timestamps
    end
  end
end
