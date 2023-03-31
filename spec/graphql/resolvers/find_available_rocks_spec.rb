require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display rocks' do
    it 'can query all available rocks' do

        #user_1, user_2, and user_3 should be returned in the query
        user = create(:user, mod: 2, program: "BE",  rock_opt_in: true)
        user_1 = create(:user, mod: 2, program: "BE", rock_opt_in: true)
        user_2 = create(:user, mod: 2, program: "BE", rock_opt_in: true)
        user_3 = create(:user, mod: 2, program: "BE", rock_opt_in: true)
        user_8 = create(:user, mod: 2, program: "BE")

        user_4 = create(:user, mod: 3, program: "BE", rock_opt_in: true)
        user_5 = create(:user, mod: 4, program: "FE", rock_opt_in: true)
        user_6 = create(:user, mod: 3, program: "FE", rock_opt_in: true)
        user_7 = create(:user, mod: 4, program: "FE")

        # creates a rock with two or more active pebbles - should not be returned
        RockAndPebble.create(rock_id: user.id, pebble_id: user_5.id, active: true)
        RockAndPebble.create(rock_id: user.id, pebble_id: user_6.id, active: true)
        RockAndPebble.create(rock_id: user.id, pebble_id: user_7.id, active: false)
        # creates a rock with one active and one inactive pebble - should be returned
        RockAndPebble.create(rock_id: user_1.id, pebble_id: user_7.id, active: false)
        RockAndPebble.create(rock_id: user_1.id, pebble_id: user_5.id, active: true)
        # creates rock with two inactive pebbles - should be returned
        RockAndPebble.create(rock_id: user_3.id, pebble_id: user_5.id, active: false)
        RockAndPebble.create(rock_id: user_3.id, pebble_id: user_6.id, active: false)
        RockAndPebble.create(rock_id: user_3.id, pebble_id: user_7.id, active: false)

      result = PairedBeSchema.execute(query).as_json

      expect(result["data"]["findAvailableRocks"].count).to eq(3)
      expect(result["data"]["findAvailableRocks"][0]["name"]).to eq(user_1.name)
      expect(result["data"]["findAvailableRocks"][1]["name"]).to eq(user_2.name)
      expect(result["data"]["findAvailableRocks"][2]["name"]).to eq(user_3.name)
    end
  end

  def query
    <<~GQL
    {
        findAvailableRocks(filter: {program: "BE", module: 2}) {

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
    GQL
  end
end
