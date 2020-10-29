require 'rails_helper'
RSpec.describe 'create rp relationship', type: :request do
  describe 'resolve', :vcr do
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
                    myRocks {
                          name
                          module
                          program
                          id
                          pronouns
                          skills
                          slack
                          image
                        }
                        myPebbles {
                          name
                          module
                          program
                          id
                          pronouns
                          skills
                          slack
                          image
                        }
                        pendingPebbles {
                          name
                          module
                          program
                          id
                          pronouns
                          skills
                          slack
                          image
                        } 
                        pendingRocks {
                          name
                          module
                          program
                          id
                          pronouns
                          skills
                          slack
                          image
                        } 
                  }
                }
              GQL
    end

    it 'creates new rock and pebble' do
      post '/graphql', params: {query: @query}
      result = JSON.parse(response.body)
      expect(RockAndPebble.count).to eq(1)
      rock_and_pebble = RockAndPebble.first
      expect(rock_and_pebble.pending).to eq(true)
      expect(result['data']['createRockPebbleRelationship']['pendingRocks'][0]['id']).to eq(@user_1.id.to_s)
      expect(result['data']['createRockPebbleRelationship']['myRocks']).to be_empty
    end
  end
end