class CreateChairs < ActiveRecord::Migration[6.1]
  def change
    create_table :chairs do |t|
      t.string :barber_name
      t.integer :company_id

      t.timestamps
    end
  end
end
