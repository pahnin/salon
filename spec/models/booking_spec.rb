require 'rails_helper'

RSpec.describe Booking, type: :model do
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
  let(:hair_cut) { example_company.services.create!(name: "Hair Cut", cost: 100) }
  let(:open_slot) { empty_chair.slots.create!(start_time: "09:00 AM") }

  context "when data is valid" do
    it "should create a booking" do
      expect {
        Booking.create!(service: hair_cut, chair: empty_chair)
      }.to change { Booking.count }.from(0).to(1)
    end
  end

  context "when data is invalid" do
    it "should raise a validation error if service is not given" do
      expect {
        Booking.create!(chair: empty_chair)
      }.to raise_error ActiveRecord::RecordInvalid
    end

    it "should raise a validation error if chair is not given" do
      expect {
        Booking.create!(service: hair_cut)
      }.to raise_error ActiveRecord::RecordInvalid
    end
  end


  describe "#allocate_slots" do
    let(:booking) { Booking.create!(service: hair_cut, chair: empty_chair) }

    it "allocates open slots to the booking" do
      expect {
        booking.allocate_slots(Slot.where(id: open_slot.id))
      }.to change { open_slot.reload.booking_id }.to(booking.id)
    end

    it "doesnt allocates slots already booked" do
      booking.allocate_slots(Slot.where(id: open_slot.id))

      new_booking = Booking.create!(service: hair_cut, chair: empty_chair)
      expect {
        booking.allocate_slots(Slot.where(id: open_slot.id))
      }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
