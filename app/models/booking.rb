class Booking < ApplicationRecord
  has_many :slots
  belongs_to :chair
  belongs_to :service


  def allocate_slots(slots)
    raise ActiveRecord::RecordInvalid if slots.select { |x| !x.draft? || x.booking_id.present?  }.any?
    raise ActiveRecord::RecordInvalid if service.no_of_slots != slots.size

    slots.update_all(booking_id: self.id, status: Slot.statuses[:confirmed])
  end
end
