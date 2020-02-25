require 'rails_helper'

module Mutations
  module Pairings
    RSpec.describe UpdatePairing, type: :request do
      describe '.resolve' do
        before :each do
          user_1 = create(:user, id: 27, name: 'Bob')
          user_2 = create(:user, id: 67, name: 'Sally')
          pairing = create(:pairing, id: 34, pairer_id: 27)
        end
        
        it 'can update a pairing' do
          post '/graphql', params: { query: query }
          json = JSON.parse(response.body)
          data = json['data']
          expect(data['updatePairing']['pairee']['name']).to eq('Sally')
          expect(data['updatePairing']['notes']).to eq('What is even happening?')
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
end
