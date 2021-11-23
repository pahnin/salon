require 'rails_helper'

RSpec.describe Slot, type: :model do
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
  let(:valid_slots) {
    [
      { service: hair_cut, start_time: "09:00 AM" },
      { start_time: "09:00 AM" }
    ]
  }

  context "when data is valid" do
    it "should create a slot with a service" do
      expect {
        empty_chair.slots.create!(valid_slots[0])
      }.to change { Slot.count }.from(0).to(1)
    end

    it "should create a slot without a service" do
      expect {
        empty_chair.slots.create!(valid_slots[1])
      }.to change { Slot.count }.from(0).to(1)
    end
  end

  context "when data is invalid" do
    it "should raise a validation error if chair is not present" do
      expect {
        Slot.create!(valid_slots[0])
      }.to raise_error ActiveRecord::RecordInvalid
    end

    it "should raise validation error if start_time is not present" do
      expect {
        empty_chair.slots.create!
      }.to raise_error ActiveRecord::RecordInvalid
    end

    it "should raise validation error if start_time is not in 30 mins format" do
      expect {
        empty_chair.slots.create!(start_time: "09:15 AM")
      }.to raise_error ActiveRecord::RecordInvalid

      expect {
        empty_chair.slots.create!(start_time: "09:35 AM")
      }.to raise_error ActiveRecord::RecordInvalid

      expect {
        empty_chair.slots.create!(start_time: "09:30 AM")
      }.to_not raise_error
    end

    it "should raise validation error if the chair already has a slot in given start_time" do
      empty_chair.slots.create!(valid_slots[1])
      expect {
        empty_chair.slots.create!(valid_slots[1])
      }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
