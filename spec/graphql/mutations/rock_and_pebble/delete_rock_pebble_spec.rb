require 'rails_helper'

RSpec.describe 'delete rock and pebble relationship', type: :request do
  describe 'resolve' do
    before :each do
      @rock_and_pebble = create :rock_and_pebble
      @query = <<~GQL
                mutation {
                  rock_and_pebble: deleteRockPebbleRelationship(
                    input: {
                      id: #{@rock_and_pebble.id}
                      reason: "I'm too busy right now. Sorry."
                    }
                  ){
                    rock { id }
                    myPebbles { id }
                  }
                }
              GQL
      @rock = @rock_and_pebble.rock
      @pebble = @rock_and_pebble.pebble
    end

    it 'deletes the pairing' do
      expect(RockAndPebble.count).to eq(1)
      post '/graphql', params: {query: @query}
      result = JSON.parse(response.body)['data']['rock_and_pebble']
      expect(result['rock']['id']).to eq(@rock.id.to_s)
      expect(result['myPebbles']).to eq([])
      expect(RockAndPebble.count).to eq(0)
    end
  end
end
