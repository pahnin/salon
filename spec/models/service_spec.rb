require 'rails_helper'

RSpec.describe Service, type: :model do
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
  let(:valid_service1) { { name: "Hair cut", cost: 100 } }
  let(:valid_service1) { { name: "shave", cost: 50 } }

  context "when data is valid" do
    it "should create a service" do
      expect {
        example_company.services.create!(valid_service1)
      }.to change { Service.count }.from(0).to(1)
    end
  end

  context "when data is invalid" do
    it "should raise a validation error if company is not present" do
      expect {
        Service.create!(valid_service1)
      }.to raise_error ActiveRecord::RecordInvalid
    end

    it "should raise validation error if name is not present" do
      expect {
        example_company.services.create!(cost: 150)
      }.to raise_error ActiveRecord::RecordInvalid
    end

    it "should raise validation error if cost is not present" do
      expect {
        example_company.services.create!(name: "Shave")
      }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
