require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display users' do
    it 'can query a single user by firebase id' do
      user = create(:user, firebase_id: 'er561v3h0si34bu56m1l2e34v7ax', name: "Ralph", program: "BE", mod: "3", id: "75", image: "https://i.ytimg.com/vi/ndsaoMFz9J4/maxresdefault.jpg", pronouns: "he/him", email: "corndog@gmail.com", slack: "Corn Dog")
      create(:user)

      user.skills.create(name: "ruby")
      user.skills.create(name: "sql")

      result = PairedBeSchema.execute(query).as_json
      expect(result["data"]["getUserByFirebaseID"]["name"]).to eq("Ralph")
      expect(result["data"]["getUserByFirebaseID"]["program"]).to eq("BE")
      expect(result["data"]["getUserByFirebaseID"]["module"]).to eq("3")
      expect(result["data"]["getUserByFirebaseID"]["id"]).to eq("75")
      expect(result["data"]["getUserByFirebaseID"]["image"]).to eq("https://i.ytimg.com/vi/ndsaoMFz9J4/maxresdefault.jpg")
      expect(result["data"]["getUserByFirebaseID"]["pronouns"]).to eq("he/him")
      expect(result["data"]["getUserByFirebaseID"]["email"]).to eq("corndog@gmail.com")
      expect(result["data"]["getUserByFirebaseID"]["slack"]).to eq("Corn Dog")
      expect(result["data"]["getUserByFirebaseID"]["phoneNumber"]).to eq("5555550100")
      expect(result["data"]["getUserByFirebaseID"]["skills"]).to eq(["ruby", "sql"])
    end
  end

  def query
    <<~GQL
      {
      	getUserByFirebaseID(id: "er561v3h0si34bu56m1l2e34v7ax") {
          name
          program
          module
          id
          image
          pronouns
          email
          phoneNumber
          slack
          skills
        }
      }
    GQL
  end
end
