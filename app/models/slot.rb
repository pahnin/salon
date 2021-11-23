class Slot < ApplicationRecord
  belongs_to :chair
  belongs_to :service, required: false

  validates :start_time, presence: true, uniqueness: { scope: :chair_id }
  validate :time_lines

  enum status: { draft: 0, confirmed: 1, current: 2, finished: 3, cancelled: 4 }

  def time_lines
    if self.start_time.present?
      minutes = self.start_time.strftime("%M").presence
      unless ( minutes.match(/00/) || minutes.match(/30/) )
        errors.add(:start_time, "must be 00 or 30")
      end
    end
  end
end
