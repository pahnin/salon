namespace :generate_slots do
  desc 'Creates open slots for all available companies for given day'
  task for_today: :environment do
    day = Date.today.strftime('%A').downcase
    Company.find_in_batches do |group|
      group.each do |company|
        limits = company.work_schedule[day]
        start_time = Time.parse(limits["start"])
        end_time = Time.parse(limits["fin"])
        company.chairs.each do |chair|
          time = start_time
          while time < end_time
            slot_fin_time = time + 30 * 60
            chair.slots.create!(start_time: time) if slot_fin_time >= end_time
            time = slot_fin_time
          end
        end
      end
    end
  end
end

namespace :clean_slots do
  desc 'Delete all open slots'
  task for_today: :environment do
    Slot.draft.where(booking_date: Date.today).destroy_all
  end
end
