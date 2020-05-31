require 'rails_helper'

module Mutations
  module Users
RSpec.describe UpdateUserOptinStatus, type: :request do
  describe '.resolve' do
    it "updates a user's opt-in status" do
      @rachel = create(:user, id: 1, name: "Rachel Lew", mod: "4")

      result = PairedBeSchema.execute(get_query).as_json
      expect(result["data"]["getUser"]["name"]).to eq("Rachel Lew")
      expect(result["data"]["getUser"]["module"]).to eq("4")
      expect(result["data"]["getUser"]["program"]).to eq("BE")
      expect(result["data"]["getUser"]["rockOptIn"]).to eq(false)

      post '/graphql', params: { query: query }

      json = JSON.parse(response.body)
      data = json['data']

      expect(data['user']['rockOptIn']).to eq(true)

      post '/graphql', params: { query: query }

      json = JSON.parse(response.body)
      data = json['data']

      expect(data['user']['rockOptIn']).to eq(false)
    end

    def get_query
      <<~GQL
      {
        getUser(id: "1") {
          name
          program
          module
          id
          image
          rockOptIn
        }
      }
      GQL
    end

    def query
      <<~GQL
      mutation {
        user: updateUserOptinStatus(input: {id: "#{@rachel.id}"}) {
          rockOptIn
        }
      }
      GQL
    end
  end
    end
  end
end
