class NoOfSlotsToServices < ActiveRecord::Migration[6.1]
  def change
    add_column :services, :no_of_slots, :integer, default: 1
  end
end
