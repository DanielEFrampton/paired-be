require 'rails_helper'

module Mutations
  module Pairings
    RSpec.describe UpdatePairing, type: :request do
      describe '.resolve' do
        before :each do
          @user_1 = create(:user, id: 27, name: 'Bob')
          @user_2 = create(:user, id: 67, name: 'Sally')
          @pairing = create(:pairing, id: 34, pairer_id: 27)
          @sms_class_double = class_double("SmsService").as_stubbed_const(:transfer_nested_constants => true)
          @sms_instance_double = instance_double("SmsService.new")
          allow(@sms_class_double).to receive(:new).and_return(@sms_instance_double)
        end

        it 'can update a pairing and sends a message to MessageGenerator' do
          expect(@sms_instance_double).to receive(:send_sms).with(@user_1.phone_number, "Sally has booked a pairing session with you from 12:00-12:30pm on Friday, April 3rd using Paired! View it at https://www.paired.tech.")

          post '/graphql', params: { query: query }
          json = JSON.parse(response.body)
          data = json['data']

          expect(data['updatePairing']['pairee']['name']).to eq('Sally')
          expect(data['updatePairing']['notes']).to eq('What is even happening?')
        end
      end

      def query
        <<~GQL
        mutation {
          updatePairing(input: {
                  id: "34"
                  pairee: 67
                  notes: "What is even happening?"
                  }) {
            pairer {
              name
              mod
              program
              id
              pronouns
                slack
                image
            }
            pairee {
              name
              mod
              program
              id
              pronouns
              slack
              image
            }
              date
              time
              id
              notes
            }
          }
        GQL
      end
    end
  end
end
