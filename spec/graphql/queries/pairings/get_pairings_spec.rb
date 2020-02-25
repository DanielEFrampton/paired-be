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
        create(:pairing, pairer_id: user_2.id, pairee_id: user_1.id)
      end

      result = PairedBeSchema.execute(query).as_json
      expect(result["data"]["getPairings"].count).to eq(10)
    end
  end

  def query
    <<~GQL
    {
      getPairings {
        id
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
