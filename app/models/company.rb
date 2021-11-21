class Company < ApplicationRecord
  has_many :services

  validates :name, :gstin, :pan, :address, :work_schedule, presence: true
end
