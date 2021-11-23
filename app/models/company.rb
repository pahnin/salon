class Company < ApplicationRecord
  has_many :services
  has_many :chairs
  has_many :slots, through: :chairs

  validates :name, :gstin, :pan, :address, :work_schedule, presence: true
end
