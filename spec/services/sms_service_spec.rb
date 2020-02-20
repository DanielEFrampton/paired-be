require 'rails_helper'

feature SmsService do
  feature 'methods' do
    feature 'send_sms' do
      scenario 'sends request to SMS microserivce and returns success or failure as JSON', :vcr do
        phone_number = ENV['TEST_PHONE_NUMBER']
        message = "Matt Simon has booked a pairing session with you on Friday,"+
                  " October 22nd on Paired! Visit http://paired.tech/schedule"+
                  " to view this booking."

        response = SmsService.new.send_sms(phone_number, message)

        # parsed_response = JSON.parse(response.body)

        # expect(parsed_response.class).to eq(Hash)
        # expect(parsed_response['result']).eq ('success')
      end
    end
  end
end
