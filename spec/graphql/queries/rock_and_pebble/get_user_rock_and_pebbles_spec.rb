require 'rails_helper'

RSpec.describe Types::QueryType do
    describe "display a user's rock(s) and pebbles" do
    it 'can query by user ID' do
        user_1 = create(:user, id: 1, name: 'Mandalorian')
        user_2 = create(:user, name: 'Baby Yoda')
        user_3 = create(:user, name: 'IG-11')

        user_1.rocks << user_2
        user_1.pebbles << user_3

        result = PairedBeSchema.execute(query).as_json
        expect(result["data"]["getUserRockAndPebble"]["rocks"][0]["name"]).to eq('Baby Yoda')
        expect(result["data"]["getUserRockAndPebble"]["pebbles"][0]["name"]).to eq('IG-11')
    end
    end

    def query
    <<~GQL
    {
        getUserRockAndPebble(id: "1") {
        rocks {
            name
            module
            program
            id
            pronouns
            skills
            slack
            image
        }
        pebbles {
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
end
