require 'rails_helper'

RSpec.describe "Companies", type: :request do
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
  let(:hair_cut) { example_company.services.create!(name: "Hair Cut", cost: 100, no_of_slots: 2) }
  let(:shave) { example_company.services.create!(name: "shave", cost: 50) }
  let(:open_slot1) { empty_chair.slots.create!(start_time: "09:00 AM") }
  let(:open_slot2) { empty_chair.slots.create!(start_time: "09:30 AM") }
  let(:open_slot3) { empty_chair.slots.create!(start_time: "10:00 AM") }

  describe "get /companies/:id/slots" do
    # invoking let variables in before block to create the data in database
    before { empty_chair && open_slot1 && open_slot2 && open_slot3 && hair_cut && shave }
    it "lists available slots" do
      get "/companies/#{example_company.id}/slots"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq ["09:00", "09:30", "10:00"]
    end

    it "if there are more than one chair slots are shown only once" do
      second_chair = example_company.chairs.create!
      second_chair.slots.create!(start_time: "09:00 AM")

      get "/companies/#{example_company.id}/slots"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq ["09:00", "09:30", "10:00"]
    end
  end
end
