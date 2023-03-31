require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display pairings' do
    it 'can query all pairings' do
      create_list(:user, 20)
      5.times do
        count = User.count - 1
        user_1 = User.offset(rand(0..count)).limit(1).first
        user_2 = User.offset(rand(0..count)).limit(1).first

        create(:pairing, pairer_id: user_1.id, pairee_id: user_2.id)
      end
        user = create(:user, mod: 2, program: "FE")
        user_1 = create(:user, mod: 2, program: "FE")
        user_2 = create(:user, mod: 1, program: "FE")

         create(:pairing, pairer_id: user.id, pairee_id: nil, date: "Wed Apr 04 2020" )
         create(:pairing, pairer_id: user_1.id, pairee_id: nil, date: "Wed Apr 04 2020" )
         create(:pairing, pairer_id: user_2.id, pairee_id: nil, date: "Wed Apr 04 2020" )


      result = PairedBeSchema.execute(query).as_json
      expect(result["data"]["getAvailablePairings"].count).to eq(2)
    end
  end

  def query
    <<~GQL
    {
        getAvailablePairings(filter: { program: "FE", module: 2, date: "Wed Apr 04 2020" }) {
          pairer {
            name
            module
            program
            id
            pronouns
            skills
            slack
            image
          }
          date
          time
          id
        }
      }
    GQL
end
end
