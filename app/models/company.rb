class Company < ApplicationRecord
  validates :name, :gstin, :pan, :address, :work_schedule, presence: true
end
