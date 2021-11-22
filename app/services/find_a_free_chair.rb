class FindAFreeChair
  def initialize(company:, service: nil, start_time: nil)
    @company = company
    @service = service
    @start_time = start_time
  end

  def list
    @company.slots.draft
      .where(booking_date: Date.today, booking_id: nil)
      .group(:start_time).pluck(:start_time).uniq.map { |x| x.strftime("%I:%M") }
  end

  def find_slots
    raise ActiveRecord::RecordNotFound if @service.blank?

    slot_start_times = (0..(@service.no_of_slots-1)).map do |i|
      Time.parse(@start_time) + 30 * 60 * i
    end

    slots = @company.slots.draft.where(booking_date: Date.today, start_time: slot_start_times, booking_id: nil).to_a.group_by { |x| x.start_time }
    slots = Slot.where(id: slots.map do |time, group| group.first.id end)

    raise ActiveRecord::RecordNotFound if slots.count != @service.no_of_slots

    slots
  end
end
