class AddBookingIdToSlots < ActiveRecord::Migration[6.1]
  def change
    add_column :slots, :booking_id, :integer
    remove_column :slots, :service_id, :integer
    remove_column :slots, :customer_id, :integer
  end
end
