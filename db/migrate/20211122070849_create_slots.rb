class CreateSlots < ActiveRecord::Migration[6.1]
  def change
    create_table :slots do |t|
      t.integer :chair_id
      t.integer :service_id, null: true
      t.integer :status, default: 0
      t.date :booking_date, default: -> { 'CURRENT_DATE' }
      t.time :start_time
      t.time :end_time
      t.integer :customer_id

      t.timestamps
    end
  end
end
