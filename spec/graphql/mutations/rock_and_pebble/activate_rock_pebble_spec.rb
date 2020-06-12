require 'rails_helper'

RSpec.describe 'activate rock and pebble relationship', type: :request do
    before :each do
            @user_1 = create :user
            @user_2 = create :user
            @user_1.pebbles << @user_2
            @relationship = RockAndPebble.first
            @user_3 = create :user
            @user_4 = create :user
            @user_3.pebbles << @user_4
            @other_relationship = RockAndPebble.last
    end

    describe '.resolve' do
        it 'switches the active status of the relationship to true' do
            expect(RockAndPebble.count).to eq(2)
            post '/graphql', params: {query: query}
            expect(@relationship.active).to eq(true)
            expect(@other_relationship.active).to eq(false)
        end
    end
        def query
            <<~GQL
                mutation {
                    rock_and_pebble: activateRockAndPebble(
                    input: {
                    id: #{@relationship.id}
                    }
                    ){
                    rock{id}
                    pebble{id}
                }
                }
            GQL
    end
end
