require 'rails_helper'

RSpec.describe 'discontinue rock and pebble relationship', type: :request do
  describe 'resolve' do
    before :each do
      @user_1 = create :user
      @user_2 = create :user
      @user_3 = create :user
      @user_1.pebbles << [@user_2, @user_3]
      @rock_and_pebble = RockAndPebble.first
      @query = <<~GQL
                mutation {
                  rock_and_pebble: discontinueRockPebbleRelationship(
                    input: {
                      id: #{@rock_and_pebble.id}
                      reason: "I'm too busy to keep mentoring."
                      user_id: #{@user_1.id}
                    }
                  ){
                    my rocks {
                                id
                                name
                                pronouns
                                program
                                module
                                slack
                    }
                    myPebbles {
                                id
                                name
                                pronouns
                                program
                                module
                                slack }

                  }
                }
              GQL
      @rock = @rock_and_pebble.rock
    end

    it 'deactivates the rock and pebble relationship' do
      expect(RockAndPebble.count).to eq(2)
      post '/graphql', params: {query: @query}
      result = JSON.parse(response.body)['data']['rock_and_pebble'] 
      expect(result['rock']['id']).to eq(@rock.id.to_s)
      expect(result['myPebbles'].first["name"]).to eq("#{@user_3.name}")
      expect(RockAndPebble.count).to eq(1)
    end
  end
end
