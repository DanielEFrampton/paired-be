require 'rails_helper'

feature SmsService do
  feature 'methods' do
    feature 'send_sms' do
      scenario 'sends request to SMS microserivce and returns success or failure as JSON', :vcr do
        phone_number = ENV['TEST_PHONE_NUMBER']
        message = "Matt Simon has booked a pairing session with you " +
                  "from 4:10-4:40pm on Thursday, October 22nd using " +
                  "Paired! View it at https://www.paired.tech."

        response_1 = SmsService.new.send_sms(phone_number, message)

        expect(response_1.class).to eq(Hash)
        expect(response_1['response']).to eq('success')

        invalid_number = '12345'

        response_2 = SmsService.new.send_sms(invalid_number, message)

        expect(response_2.class).to eq(Hash)
        expect(response_2['response']).to eq('Invalid request')
      end
    end
  end
end
