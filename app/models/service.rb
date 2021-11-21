class Service < ApplicationRecord
  belongs_to :company

  validates :name, :company, :cost, presence: true
end
