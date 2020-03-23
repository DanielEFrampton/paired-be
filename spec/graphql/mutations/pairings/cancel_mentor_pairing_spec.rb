require 'rails_helper'
module Mutations
  module Pairings
RSpec.describe CancelMentorPairing, type: :request do
    before :each do
      @user = create(:user, id: 234)
      @user_2 = create(:user, id: 123)
      @user_3 = create(:user, id: 34)
      @pairing = create(:pairing, id: 111, pairer_id: 234,  pairee_id: 123)
      create(:pairing, pairer_id: 234,  pairee_id: 34)
      create(:pairing, pairer_id: 234,  pairee_id: nil)
      @sms_class_double = class_double("SmsService").as_stubbed_const(:transfer_nested_constants => true)
      @sms_instance_double = instance_double("SmsService.new")
      allow(@sms_class_double).to receive(:new).and_return(@sms_instance_double)
    end
    describe '.resolve' do
        it 'cancels a mentor pairing' do
          expect(Pairing.count).to eq(3)
          post '/graphql', params: {query: query}
          expect(Pairing.count).to eq(3)
        end

    it 'returns the pairees information after cancellation' do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']

      expect(data['cancelMentorPairing']['pairee']).to eq(nil)
      expect(data['cancelMentorPairing']['pairer']["name"]).to eq(@user.name)
    end
    it 'removes time and notes from pairing after cancellation' do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      expect(@pairing.notes).to eq(nil)
    end
  end
    def query
      <<~GQL
      mutation {
        cancelMentorPairing(input: {
                id: "#{@pairing.id}"
                }) {
          pairer {
            name
          }
          pairee {
            name
            email
            phoneNumber
          }
            date
            time
            id
          }
        }
      GQL
    end
    end
  end
end
