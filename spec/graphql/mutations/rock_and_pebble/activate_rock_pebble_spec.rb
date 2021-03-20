require 'rails_helper'

RSpec.describe 'activate rock and pebble relationship', type: :request do
    before :each do
            @user_1 = create :user
            @user_2 = create :user
            @user_3 = create :user
            @user_1.pebbles << [@user_2, @user_3]
            @relationship = RockAndPebble.first
    end

    describe '.resolve', :vcr do
        it 'switches the active status of the relationship to true and send rock accepted email' do
            expect(RockAndPebble.count).to eq(2)
            expect(@relationship.active).to eq(false)
            expect(@relationship.pending).to eq(true)
            post '/graphql', params: {query: query}
            result = JSON.parse(response.body)
      
            expect(result['data']['rock_and_pebble']['myPebbles'][0]['id']).to eq(@user_2.id.to_s)
            expect(result['data']['rock_and_pebble']['myRocks']).to be_empty
            expect(result['data']['rock_and_pebble']['pendingPebbles'][0]['id']).to eq(@user_3.id.to_s)

            expect(@relationship.reload.active).to eq(true)
            expect(@relationship.reload.pending).to eq(false)

            expect do
            @relationship.update(active: false, pending: true)
            post '/graphql', params: {query: query}
            end.
            to change { ActionMailer::Base.deliveries.count }.by(1)
          end
    end
        def query
            <<~GQL
                mutation {
                    rock_and_pebble: activateRockPebbleRelationship(
                    input: {
                    rockId: #{@user_1.id}
                    pebbleId: #{@user_2.id}
                    }
                    ){
                      myRocks {
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
                        slack
                      }
                      pendingPebbles {
                        id
                        name
                        pronouns
                        program
                        module
                        slack
                      }
                }
                }
            GQL
    end
end
