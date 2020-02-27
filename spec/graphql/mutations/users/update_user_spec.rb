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
      expect(data['user']['module']).to eq('2')
      expect(data['user']['email']).to eq('cap@gmail.com')
      expect(data['user']['pronouns']).to eq('she/her')
    end

    it 'returns updated skills for a user' do
      cheryl = create(:user, id: 10, name: "Lana", email: "tunt@gmail.com", mod: "4", program: "BE", pronouns: "she/her", slack:"@cheryl_tunt")
      pam = create(:user)
      skill_1 = cheryl.skills.create(name: "sql")
      skill_2 = cheryl.skills.create(name: "javascript")
      skill_3 = cheryl.skills.create(name: "graphql")

      expect(cheryl.skills).to eq([skill_1, skill_2, skill_3])

      post '/graphql', params: { query: query }

      result = JSON.parse(response.body)
      skills = result["data"]["user"]["skills"]

      expect(skills[0]).to eq('ruby')
      expect(skills[1]).to eq('react')
      expect(skills[2]).to eq('css')
    end

    it 'it returns updated skill in correct position' do
      bob = create(:user, id: 11, name: "Bob", email: "tunt@gmail.com", mod: "4", program: "BE", pronouns: "she/her", slack:"@cheryl_tunt")
      pam = create(:user)
      skill_1 = bob.skills.create(name: "sql")
      skill_2 = bob.skills.create(name: "javascript")
      skill_3 = bob.skills.create(name: "graphql")

      expect(bob.skills).to eq([skill_1, skill_2, skill_3])

      post '/graphql', params: { query: query_2 }

      result = JSON.parse(response.body)
      skills = result["data"]["user"]["skills"]

      expect(skills[0]).to eq('sql')
      expect(skills[1]).to eq('react')
      expect(skills[2]).to eq('graphql')
    end

    def query
      <<~GQL
      mutation {
        user: updateUser(
          input: {
            id: "10"
            name: "Carl Crockett"
            email: "cap@gmail.com"
            module: 2
            program: "BE"
            pronouns: "she/her"
            slack: "capleugh"
            skills: ["ruby", "react", "css"]
          }
          ) {
            name
            program
            module
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

    def query_2
      <<~GQL
      mutation {
        user: updateUser(
          input: {
            id: "11"
            name: "Carl Crockett"
            email: "cap@gmail.com"
            module: 2
            program: "BE"
            pronouns: "she/her"
            slack: "capleugh"
            skills: ["", "react", ""]
          }
          ) {
            name
            program
            module
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
