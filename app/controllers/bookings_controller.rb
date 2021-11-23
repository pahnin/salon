class BookingsController < ApplicationController

  def create
    booking = nil
    Booking.transaction {
      slots = FindAFreeChair.new(
        company: company,
        service: service,
        start_time: start_time
      ).find_slots

      booking = Booking.create!(service: service, chair: slots.first.chair)
      booking.allocate_slots(slots)
    }

    render json: { success: true, booking_id: booking.id }
  end

  private

  def permitted_params
    params.require(:booking).permit(:company_id, :start_time, :service_id)
  end

  def company
    Company.find permitted_params[:company_id]
  end

  def service
    Service.find permitted_params[:service_id]
  end

  def start_time
    permitted_params[:start_time]
  end
end
