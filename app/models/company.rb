class Company < ApplicationRecord
  has_many :services
  has_many :chairs

  validates :name, :gstin, :pan, :address, :work_schedule, presence: true
end
