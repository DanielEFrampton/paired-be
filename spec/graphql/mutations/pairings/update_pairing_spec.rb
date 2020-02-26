require 'rails_helper'

module Mutations
  module Pairings
    RSpec.describe UpdatePairing, type: :request do
      describe '.resolve' do
        before :each do
          @user_1 = create(:user, name: 'Bob')
          @user_2 = create(:user, name: 'Sally')
          @pairing = create(:pairing, pairer_id: @user_1.id, pairee_id: nil)
          @sms_class_double = class_double("SmsService").as_stubbed_const(:transfer_nested_constants => true)
          @sms_instance_double = instance_double("SmsService.new")
          allow(@sms_class_double).to receive(:new).and_return(@sms_instance_double)
        end

        it 'can update a pairing and sends a message to MessageGenerator' do

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
                  id: #{@pairing.id}
                  pairee: #{@user_2.id}
                  notes: "What is even happening?"
                  }) {
            pairer {
              name
              module
              program
              id
              pronouns
                slack
                image
            }
            pairee {
              name
              module
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
