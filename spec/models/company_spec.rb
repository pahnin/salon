require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:valid_company_data) {
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
  }
  context "when data is valid" do
    it "should create a company" do
      expect {
        Company.create!(valid_company_data)
      }.to change { Company.where(gstin: "123ABC").count }.from(0).to(1)
    end

    it "an existing company should return correct data" do
      new_company = Company.create!(valid_company_data)
      expect(new_company.work_schedule["friday"]["start"]).to eq "09:00 AM"
    end
  end

  context "when data is invalid" do
    it "should raise a validation error if name is not present" do
      expect {
        Company.create!(valid_company_data.tap { |x| x[:name] = "" } )
      }.to raise_error ActiveRecord::RecordInvalid
    end

    it "should raise a validation error if gstin is not present" do
      expect {
        Company.create!(valid_company_data.tap { |x| x[:gstin] = "" } )
      }.to raise_error ActiveRecord::RecordInvalid
    end

    it "should raise a validation error if pan is not present" do
      expect {
        Company.create!(valid_company_data.tap { |x| x[:pan] = "" } )
      }.to raise_error ActiveRecord::RecordInvalid
    end

    it "should raise a validation error if address is not present" do
      expect {
        Company.create!(valid_company_data.tap { |x| x[:address] = "" } )
      }.to raise_error ActiveRecord::RecordInvalid
    end

    it "should raise a validation error if work_schedule is not present" do
      expect {
        Company.create!(valid_company_data.tap { |x| x[:work_schedule] = "" } )
      }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
