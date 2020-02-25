require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display pairing' do
    it 'can query a single pairing' do
      user_1 = create(:user, name: 'Bobby')
      user_2 = create(:user, name: 'Sue')
      user_3 = create(:user)

      create(:pairing, id: 1, pairer_id: user_1.id, pairee_id: user_2.id)
      create(:pairing, pairer_id: user_2.id, pairee_id: user_3.id)

      result = PairedBeSchema.execute(query).as_json
      expect(result["data"]["getPairing"]["pairer"]["name"]).to eq('Bobby')
    end
  end
  def query
    <<~GQL
    {
    getPairing(id: "1") {
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
      pairee {
        name
      }
      date
      time
      id
        }
      }
    GQL
  end
end
