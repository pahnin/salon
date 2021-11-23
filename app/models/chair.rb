class Chair < ApplicationRecord
  belongs_to :company

  has_many :slots

  validates :company, presence: true
end
