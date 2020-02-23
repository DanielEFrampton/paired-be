require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display user pairings' do
    it 'can query a user pairings' do
      user_1 = create(:user, id: 1, name: 'Bobby')
      user_2 = create(:user, name: 'Sue')
      user_3 = create(:user)

      create(:pairing, pairer_id: user_1.id, pairee_id: user_2.id)
      create(:pairing, pairer_id: user_2.id, pairee_id: user_1.id)
      create(:pairing, id: 3, pairer_id: user_2.id, pairee_id: user_3.id)

      result = PairedBeSchema.execute(query).as_json

      expect(result["data"]["getUserPairings"].first["pairer"]["name"]).to eq("Bobby")
      expect(result["data"]["getUserPairings"].first["pairee"]["name"]).to eq("Sue")
      expect(result["data"]["getUserPairings"].last["pairee"]["name"]).to eq("Bobby")
    end
  end

  def query
    <<~GQL
      {
      getUserPairings(id: "1") {
      pairer {
        name
      }
      pairee {
        name
      }
      date
      time
      }
    }
    GQL
end
end
