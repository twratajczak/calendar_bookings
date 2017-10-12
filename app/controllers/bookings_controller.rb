class BookingsController < ApplicationController
  def create
    room = Room.find_by(params[:room_id])
    if BookingService.new(room).vacant?(Date.parse(params[:start]), Date.parse(params[:end]))
      booking = Booking.new(booking_params)
      booking.save

      render json: { message: 'Booking created.' }, status: :ok
    else
      render json: { message: 'Booking conflicts with an existing booking' }, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.permit(:start, :end, :room_id)
  end
end
