class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :gstin
      t.string :pan
      t.string :address
      t.json :work_schedule

      t.timestamps
    end
  end
end
