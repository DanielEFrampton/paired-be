require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display users' do
    it 'can query a single user' do
      create(:user, id: 1, name: "Cate Blanchett")
      create_list(:user, 4)

      result = PairedBeSchema.execute(query).as_json

      expect(result["data"]["getUser"]["name"]).to eq("Cate Blanchett")
      expect(result["data"]["getUser"]["mod"]).to eq("3")
      expect(result["data"]["getUser"]["program"]).to eq("BE")
    end
  end

  def query
    <<~GQL
    {
      getUser(id: "1") {
        name
        program
        mod
      }
    }
    GQL
end
end
