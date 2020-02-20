require 'rails_helper'

feature TwilioService do
  feature 'methods' do
    feature 'request appointment' do
      scenario 'returns message sid when message is sent', :vcr do
        name = 'Matt Simon'
        phone_number = ENV['TEST_PHONE_NUMBER']
        time = '02-28-2020 16:00 UTC -7'

        response = TwilioService.new.appointment_request(name, phone_number, time)
        binding.pry
        expect(response).to be_truthy
      end
    end
  end
end
