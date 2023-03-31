require "rails_helper"

RSpec.describe "discontinue rock and pebble relationship", type: :request do
  describe "resolve", :vcr do
    before :each do
      @user_1 = create :user
      @user_2 = create :user
      @user_3 = create :user
      @user_1.pebbles << [@user_2, @user_3]
      RockAndPebble.where(pebble_id: @user_2.id).update(
        active: true,
        pending: false,
      )
      RockAndPebble.where(pebble_id: @user_3.id).update(
        active: true,
        pending: false,
      )
      @rock_and_pebble = RockAndPebble.where(pebble_id: @user_3).first

      @query = <<~GQL
                mutation {
                  rock_and_pebble: discontinueRockPebbleRelationship(
                    input: {
                      rockId: #{@rock_and_pebble.rock_id}
                      pebbleId: #{@rock_and_pebble.pebble_id}
                      reason: "I'm too busy right now. Sorry."
                      userRelationship: "pebble"
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
                    }}
                }
              GQL
      @rock = @rock_and_pebble.rock
    end

    it "discontinues the rock and pebble relationship" do
      expect(@rock_and_pebble.active).to eq(true)
      post "/graphql", params: { query: @query }
      result = JSON.parse(response.body)["data"]["rock_and_pebble"]
      expect(result["myRocks"]).to be_empty
      expect(result["myPebbles"].first["name"]).to eq("#{@user_2.name}")
      expect(result["pendingPebbles"]).to be_empty
      expect(@rock_and_pebble.reload.active).to eq(false)
    end
  end
end
