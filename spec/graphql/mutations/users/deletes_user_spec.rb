require 'rails_helper'
module Mutations
  module Users
RSpec.describe DeleteUser, type: :request do
  describe '.resolve' do
    it 'deletes a user' do
      create_list(:user, 3)
      create(:user, id: 121)
      users = User.all
      expect(User.count).to eq(4)
      post '/graphql', params: {query: query}
      expect(User.count).to eq(3)
    end

    it 'returns id of deleted User after user deletion' do
      user = create(:user, id: 121)
      expect(User.count).to eq(1)

      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']
      expect(data["deleteUser"]["name"]).to eq(user.name)

      expect(User.count).to eq(0)
    end

    it 'deletes all skills and open pairings associated with user' do
      user = create(:user, id: 121)
      user_2 = create(:user)
      user.skills.create(name: "Ruby")
      user.skills.create(name: "Rails")
      pairing_1 = create(:pairing, pairer_id: user.id, pairee_id: nil)
      pairing_2 = create(:pairing, pairer_id: user_2.id, pairee_id: nil)

      expect(Skill.count).to eq(2)
      expect(Pairing.count).to eq(2)

      post '/graphql', params: { query: query }

      expect(Skill.count).to eq(0)
      expect(Pairing.count).to eq(1)
      expect(Pairing.first).to eq(pairing_2)
    end
  end
    def query
      <<~GQL
      mutation {
        deleteUser(
        	input:{
            id: "121" } ) {
          name
        }
      }
      GQL
    end

    end
  end
end
