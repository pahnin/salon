class Service < ApplicationRecord
  belongs_to :company

  has_many :slots

  validates :name, :company, :cost, presence: true
end
