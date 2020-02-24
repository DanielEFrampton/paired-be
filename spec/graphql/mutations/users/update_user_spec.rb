require 'rails_helper'

module Mutations
  module Users
RSpec.describe UpdateUser, type: :request do
  describe '.resolve' do
    it 'updates a user' do
      pam = create(:user)
      cheryl = create(:user, id: 10, name: "Cheryl", email: "tunt@gmail.com", mod: "4", program: "BE", pronouns: "she/her", slack:"@cheryl_tunt")

      skill_1 = cheryl.skills.create(name: "sql")
      skill_2 = cheryl.skills.create(name: "javascript")

      post '/graphql', params: { query: query }

      json = JSON.parse(response.body)
      data = json['data']

      expect(data['user']['name']).to eq('Carl Crockett')
      expect(data['user']['program']).to eq('BE')
      expect(data['user']['mod']).to eq('2')
      expect(data['user']['email']).to eq('cap@gmail.com')
      expect(data['user']['pronouns']).to eq('she/her')
    end

    it 'returns updated skills for a user' do
      pam = create(:user)
      cheryl = create(:user, id: 10, name: "Lana", email: "tunt@gmail.com", mod: "4", program: "BE", pronouns: "she/her", slack:"@cheryl_tunt")
      skill_1 = cheryl.skills.create(name: "sql")
      skill_2 = cheryl.skills.create(name: "javascript")

      expect(cheryl.skills).to eq([skill_1, skill_2])

      post '/graphql', params: { query: query }



      # still working on the expectation here
    end

    def query
      <<~GQL
      mutation {
        user: updateUser(
          input: {
            id: "10"
            name: "Carl Crockett"
            email: "cap@gmail.com"
            mod: "2"
            program: "BE"
            pronouns: "she/her"
            slack: "capleugh"
            skills: ["ruby", "react"]
          }
          ) {
            name
            program
            mod
            id
            image
            pronouns
            email
            slack
            skills
          }
        }
      GQL
    end
  end
end
  end
end
