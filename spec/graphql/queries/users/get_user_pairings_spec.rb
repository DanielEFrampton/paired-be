require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display user pairings' do
    it 'can query a user pairings' do
      user_1 = create(:user, id: 1, name: 'Bobby')

      create(:pairing, pairer_id: user_1.id, pairee_id: nil)
      create(:pairing, pairer_id: user_1.id, pairee_id: nil)
      create(:pairing, pairer_id: user_1.id, pairee_id: nil)
      expect(Pairing.count).to eq(3)
      result = PairedBeSchema.execute(query).as_json

      expect(result["data"]["getUserPairings"].count).to eq(3)
    end
  end

  def query
    <<~GQL
    { getUserPairings(id: "1")
      {
       pairer {
         name
         module
         program
         id
         pronouns
         slack
         image
       }
       pairee {
         name
         module
         program
         pronouns
         slack
         image
       }
       date
       time
       id
       notes
     }
    }
    GQL
  end
end
