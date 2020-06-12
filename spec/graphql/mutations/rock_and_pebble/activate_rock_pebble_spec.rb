require 'rails_helper'

RSpec.describe 'activate rock and pebble relationship', type: :request do
    before :each do
            @user_1 = create :user
            @user_2 = create :user
            @user_1.pebbles << @user_2
            @relationship = RockAndPebble.first
    end

    describe '.resolve' do
        it 'switches the active status of the relationship to true and send rock accepted email' do
            expect(RockAndPebble.count).to eq(1)
            expect(@relationship.active).to eq(false)
            post '/graphql', params: {query: query}
            result = JSON.parse(response.body)
            expect(result['data']['rock_and_pebble']['id']).to eq(@relationship.id.to_s)
            expect(result['data']['rock_and_pebble']['active']).to eq(true)
            expect(result['data']['rock_and_pebble']['rock']['id']).to eq(@user_1.id.to_s)
            expect(result['data']['rock_and_pebble']['pebble']['id']).to eq(@user_2.id.to_s)
            expect do
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
                    id: #{@relationship.id}
                    }
                    ){
                      id
                      rock {
                        id
                        name
                        pronouns
                        program
                        module
                        slack
                      }
                      pebble {
                        id
                        name
                        pronouns
                        program
                        module
                        slack
                      }
                      active

                }
                }
            GQL
    end
end
