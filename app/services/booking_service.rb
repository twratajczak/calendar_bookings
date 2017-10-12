class BookingService
  def initialize(room)
    @room = room
  end

  def vacant?(from, to)
    @room.bookings.where("(start <= :from AND end >= :from)
                       OR (start <= :to AND end >= :to)
                       OR (start >= :from AND end <= :to)",
                          {from: from, to: to}).empty?
  end
end
