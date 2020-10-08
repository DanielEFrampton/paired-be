require 'rails_helper'

RSpec.describe 'discontinue rock and pebble relationship', type: :request do
    describe 'resolve', :vcr do
    before :each do
      @user_1 = create :user
      @user_2 = create :user
      @user_3 = create :user
      @user_4 = create :user
      @user_1.pebbles << [@user_2, @user_3]
      RockAndPebble.last.update(active: true)
      RockAndPebble.first.update(active: true)
      @rock_and_pebble = RockAndPebble.last
      
      @query1 = <<~GQL
                mutation {
                  rock_and_pebble: discontinueRockPebbleRelationship(
                    input: {
                      id: #{@rock_and_pebble.id}
                      reason: "I'm too busy to keep mentoring."
                      userId: #{@user_1.id}
                    }
                  ){

                    myRocks {
                                id
                                name
                                slack
                    }
                    myPebbles {
                                id 
                                name
                                slack
                              }
                  }
                }
              GQL

      @rock = @rock_and_pebble.rock
    end

    it 'deactivates the rock and pebble relationship' do
      expect(@rock_and_pebble.reload.active).to eq(true)

      post '/graphql', params: {query: @query1}
      result = JSON.parse(response.body)["data"]["rock_and_pebble"]

      expect(result['myRocks']).to be_empty
      expect(result['myPebbles'].first['name']).to eq("#{@user_2.name}")
      expect(@rock_and_pebble.reload.active).to eq(false)
    end
  end
end
