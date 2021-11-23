require 'rails_helper'

RSpec.describe "Bookings", type: :request do
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

  describe "POST /bookings" do
    # invoking let variables in before block to create the data in database
    before { empty_chair && open_slot1 && open_slot2 && open_slot3 && hair_cut && shave }
    it "creates a booking and allocates slots, given slots are available" do
      expect {
        post "/bookings", params: { booking: { company_id: example_company.id, service_id: hair_cut.id, start_time: "09:00 AM" } }
      }.to change { Booking.count }.to(1)
    end

    it "slots get the booking id and other slots are unchanged" do
      post "/bookings", params: { booking: { company_id: example_company.id, service_id: hair_cut.id, start_time: "09:00 AM" } }
      expect(response).to have_http_status(:success)
      expect(Booking.count).to eq 1

      booking = Booking.first
      expect(open_slot1.reload.booking_id).to eq booking.id
      expect(open_slot1.reload.status).to eq "confirmed"
      expect(open_slot3.reload.booking_id).to be nil
      expect(open_slot3.reload.status).to eq "draft"
    end

    it "bookings cant be overlapped" do
      post "/bookings", params: { booking: { company_id: example_company.id, service_id: hair_cut.id, start_time: "09:00 AM" } }
      expect(Booking.count).to eq 1
      expect(response).to have_http_status(:success)

      post "/bookings", params: { booking: { company_id: example_company.id, service_id: shave.id, start_time: "09:00 AM" } }
      expect(Booking.count).to eq 1
      expect(response).to have_http_status(:not_found)
    end

    it "if there are more than one chair bookings can be done on both chairs" do
      second_chair = example_company.chairs.create!
      second_chair.slots.create!(start_time: "09:00 AM")

      post "/bookings", params: { booking: { company_id: example_company.id, service_id: hair_cut.id, start_time: "09:00 AM" } }
      expect(Booking.count).to eq 1
      expect(response).to have_http_status(:success)

      post "/bookings", params: { booking: { company_id: example_company.id, service_id: shave.id, start_time: "09:00 AM" } }
      expect(Booking.count).to eq 2
      expect(response).to have_http_status(:success)
    end
  end
end
