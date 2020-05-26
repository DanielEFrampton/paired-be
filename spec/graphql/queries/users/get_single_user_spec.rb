require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display users' do
    it 'can query a single user' do
      create(:user, id: 1, name: "Cate Blanchett", mod: "3")
      create_list(:user, 4)

      result = PairedBeSchema.execute(query).as_json
      expect(result["data"]["getUser"]["name"]).to eq("Cate Blanchett")
      expect(result["data"]["getUser"]["module"]).to eq("3")
      expect(result["data"]["getUser"]["program"]).to eq("BE")
      expect(result["data"]["getUser"]["rockOptIn"]).to eq(false)
    end
  end

  def query
    <<~GQL
    {
      getUser(id: "1") {
        name
        program
        module
        id
        image
        rockOptIn
      }
    }
    GQL
  end
end
