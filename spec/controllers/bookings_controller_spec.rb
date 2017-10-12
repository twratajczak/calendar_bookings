require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  describe "POST #create" do
    let!(:room) { create :room }
    let!(:booking) { create :booking, room_id: room.id, start: '2017-01-10', end: '2017-01-20'}

    tests = [
      {start: '2017-01-01', end: '2017-01-01', resp: :success},
      {start: '2017-01-01', end: '2017-01-10', resp: :unprocessable_entity},
      {start: '2017-01-10', end: '2017-01-20', resp: :unprocessable_entity},
      {start: '2017-01-11', end: '2017-01-19', resp: :unprocessable_entity},
      {start: '2017-01-20', end: '2017-02-01', resp: :unprocessable_entity},
      {start: '2017-02-01', end: '2017-02-01', resp: :success},
    ]

    tests.each do |test|
      it "returns http #{test[:success]}" do
        post :create, {params: {room_id: 1, start: test[:start], end: test[:end]}}
        expect(response).to have_http_status(test[:resp])
      end
    end
  end
end
