require 'rails_helper'

RSpec.describe FindAFreeChair, type: :model do
  let(:example_company) {
    Company.create(
      {
        name: "A Salon",
        gstin: "123ABC",
        pan: "DVG123H",
        address: "404, 25th main, BTM, stage 2, Bangalore",
        work_schedule: {
          monday: {
            start: "09:00 AM",
            fin: "09:00 PM"
          },
          tuesday: {
            start: "09:00 AM",
            fin: "09:00 PM"
          },
          wednesday: {
            start: "09:00 AM",
            fin: "09:00 PM"
          },
          thursday: {
            start: "09:00 AM",
            fin: "09:00 PM"
          },
          friday: {
            start: "09:00 AM",
            fin: "09:00 PM"
          },
          saturday: {
            start: "09:00 AM",
            fin: "09:00 PM"
          },
          sunday: {
            start: "09:00 AM",
            fin: "09:00 PM"
          }
        }
      }
    )
  }

  let(:empty_chair) { example_company.chairs.create! }
  let(:hair_cut) { example_company.services.create!(name: "Hair Cut", cost: 100, no_of_slots: 3) }
  let(:shave) { example_company.services.create!(name: "shave", cost: 50) }
  let(:open_slot1) { empty_chair.slots.create!(start_time: "09:00 AM") }
  let(:open_slot2) { empty_chair.slots.create!(start_time: "09:30 AM") }
  let(:open_slot3) { empty_chair.slots.create!(start_time: "10:00 AM") }

  describe "#list" do
    before { empty_chair }
    it "retuns list of available times" do
      # invoking the let variable creates the slots
      open_slot1
      open_slot2
      open_slot3

      expect(FindAFreeChair.new(
        company: example_company
      ).list).to eq ["09:00", "09:30", "10:00"]
    end
  end

  describe "#find_slots" do
    before { empty_chair }
    # Fetches the slot numbers for given company, start_time and service
    it "should return slot when there is availability" do
      # invoking the let variable creates the slots
      open_slot1
      open_slot2
      open_slot3

      expect(FindAFreeChair.new(
        company: example_company,
        service: hair_cut,
        start_time: "09:00 AM"
      ).find_slots.pluck(:id).sort).to eq [open_slot1.id, open_slot2.id, open_slot3.id].sort
    end


    it "should raise error if slots no available" do
      expect {
        FindAFreeChair.new(
          company: example_company,
          service: hair_cut,
          start_time: "09:00 AM"
        ).find_slots
      }.to raise_error ActiveRecord::RecordNotFound
    end

    it "should raise error if partial slots available" do
      open_slot1
      open_slot2
      expect {
        FindAFreeChair.new(
          company: example_company,
          service: hair_cut,
          start_time: "09:00 AM"
        ).find_slots
      }.to raise_error ActiveRecord::RecordNotFound
    end


    it "should raise error if partial slots available" do
      open_slot1
      open_slot2

      new_booking = Booking.create!(service: shave, chair: empty_chair)
      new_booking.allocate_slots(Slot.where(id: open_slot3.id))

      expect {
        FindAFreeChair.new(
          company: example_company,
          service: hair_cut,
          start_time: "09:00 AM"
        ).find_slots
      }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
