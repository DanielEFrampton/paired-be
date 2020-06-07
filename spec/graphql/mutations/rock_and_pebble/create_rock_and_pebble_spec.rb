require 'rails_helper'
RSpec.describe 'create rp relationship', type: :request do
  describe 'resolve' do
    before :each do
      @user_1 = create :user
      @user_2 = create :user

      @query = <<~GQL
                mutation {
                  rock_and_pebble: CreateRockPebbleRelationship(
                    input: {
                      rock_id: #{@user_1.id}
                      pebble_id: #{@user_2.id}
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
      expect(RockAndPebble.last.id).to eq(result['id'])
    end
  end
end
