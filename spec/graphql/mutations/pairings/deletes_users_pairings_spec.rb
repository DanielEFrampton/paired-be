require 'rails_helper'
module Mutations
  module Pairings
RSpec.describe DeleteUserPairings, type: :request do
  describe '.resolve' do
        it 'deletes a user pairings' do
          create_list(:user, 3)
          create(:user, id: 122)
          users = User.all
          create(:pairing, pairer_id: 122,  pairee_id: users[3].id )
          create(:pairing, pairer_id: users[1].id, pairee_id: users[2].id )
          expect(Pairing.count).to eq(2)
          post '/graphql', params: {query: query}
          expect(Pairing.count).to eq(1)
        end

    it 'returns a nil for a pairer after deletion' do

      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']
      expect(data['deletePairings']['pairer']).to eq(nil)
    end
  end
    def query
      <<~GQL
      mutation {
     deletePairings(
        	input:{
            id: "122" } ) {
        pairer { id }
      }
    }
      GQL
    end

    end
  end
end
