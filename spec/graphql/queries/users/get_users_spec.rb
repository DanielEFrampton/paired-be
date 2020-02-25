require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display users' do
    it 'can query all users' do
      create(:user, name: "Bruce Easley")
      create_list(:user, 4)

      result = PairedBeSchema.execute(query).as_json
      expect(result["data"]["getUsers"].count).to eq(5)
      expect(result["data"]["getUsers"].first["name"]).to eq("Bruce Easley")

      users = User.all
      expect(result.dig("data", "getUsers")).to match_array(
      users.map { |user| {"module" => user.mod.to_s, "name" => user.name, "program" => user.program} })
    end
  end

  def query
    <<~GQL
    {
      getUsers {
        name
        program
        module
        }
    }
    GQL
  end
end
