class Chair < ApplicationRecord
  belongs_to :company

  validates :company, presence: true
end
