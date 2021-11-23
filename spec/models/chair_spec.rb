require 'rails_helper'

RSpec.describe Chair, type: :model do
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

  context "when data is valid" do
    it "should create a chair with a barber name" do
      expect {
        example_company.chairs.create!(barber_name: "Santhanam")
      }.to change { Chair.count }.from(0).to(1)
    end

    it "should create a chair without a barber name" do
      expect {
        example_company.chairs.create!
      }.to change { Chair.count }.from(0).to(1)
    end
  end

  context "when data is invalid" do
    it "should raise a validation error if company is not present" do
      expect {
        Chair.create!
      }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
