require 'rails_helper'
module Mutations
  module Users
RSpec.describe CreateUser, type: :request do
  describe '.resolve' do
        it 'creates a user' do
          expect(User.count).to eq(0)
          post '/graphql', params: {query: query}
          expect(User.count).to eq(1)
        end

    it 'returns a user' do

      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']
         expect(data['user']['name']).to eq('Samantha')
         expect(data['user']['program']).to eq('BE')
         expect(data['user']['mod']).to eq('3')
         expect(data['user']['email']).to eq('so@gmail.com')
         expect(data['user']['pronouns']).to eq('she/her')
    end
  end
      def query
        <<~GQL
        mutation {
          user: createUser(
          input: {
        name: "Samantha"
        email: "so@gmail.com"
        image: "https://robohash.org/image"
        firebaseID: "425tgw2g4w43"
        mod: "3"
        program: "BE"
        phoneNumber: "4231563232"
        pronouns: "she/her"
        slack: "rer7891"
        skills: ["ruby", "rails", "graphql"]
      }
    ) {
      name
      program
      mod
      id
      image
      pronouns
      email
      slack
      skills
        { id }
    }
  }
  GQL
end
  end
end
end
