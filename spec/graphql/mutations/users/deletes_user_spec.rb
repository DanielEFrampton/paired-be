require 'rails_helper'
module Mutations
  module Users
RSpec.describe DeleteUser, type: :request do
  describe '.resolve' do
        it 'deletes a user' do
          create_list(:user, 3)
          create(:user, id: 1)
          users = User.all

          expect(User.count).to eq(4)
          post '/graphql', params: {query: query}
          expect(User.count).to eq(3)
        end

    it 'returns a name for deleted user after deletion' do
      user = create(:user, id: 1)
      expect(User.count).to eq(1)

      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']
      expect(data['deleteUser']['name']).to eq(user.name)

      expect(User.count).to eq(0)
    end
  end
    def query
      <<~GQL
      mutation {
     deleteUser(
        	input:{
            id: "1" } ) {
            name
      }
    }
      GQL
    end

    end
  end
end
