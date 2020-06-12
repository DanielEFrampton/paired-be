require 'rails_helper'
RSpec.describe 'create rp relationship', type: :request do
  describe 'resolve' do
    before :each do
      @user_1 = create :user
      @user_2 = create :user

      @query = <<~GQL
                mutation {
                  createRockPebbleRelationship(
                    input: {
                      rockId: #{@user_1.id}
                      pebbleId: #{@user_2.id}
                    }
                  ){
                    id
                    rock { id }
                    pebble { id }
                  }
                }

              GQL
    end

    it 'creates new rock and pebble' do
      post '/graphql', params: {query: @query}
      result = JSON.parse(response.body)
      expect(RockAndPebble.count).to eq(1)
      expect(result["data"]["createRockPebbleRelationship"]["id"]).to eq(RockAndPebble.last.id.to_s)
    end
  end
end
