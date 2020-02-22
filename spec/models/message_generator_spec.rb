require 'rails_helper'

describe MessageGenerator do
  describe 'class methods' do
    describe 'pairing_notification' do
      it 'generates a string message notifying a person about a pairing with given name and date' do
        generator = MessageGenerator.new
        name = 'Matt Simon'
        date = 'Fri Oct 22 2020'
        time = 'afternoon'

        message = generator.pairing_notification(name, date, time)

        expected_message = "Matt Simon has booked a pairing session with you" +
                           "from 4:10-4:40pm on Friday, October 22nd on " +
                           "Paired! Visit http://paired.tech/schedule to " +
                           "view this booking."

        expect(message).to eq(expected_message)
      end
    end
  end
end
