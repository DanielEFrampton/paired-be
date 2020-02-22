module Types
  class QueryType < Types::BaseObject
    field :get_users, [Types::UserType], null: false, description: 'Returns a list of users'
    field :skills, [Types::SkillType], null: false, description: 'Returns a list of skills'
    field :get_pairings, [Types::PairingType], null: false, description: 'Returns all pairings'

    field :get_user, Types::UserType, null: false, description: 'Returns a single user by id' do
      argument :id, ID, required: true
    end

    field :get_pairing, Types::PairingType, null: false, description: 'Returns a single pairing by id' do
      argument :id, ID, required: true
    end


    def get_users
      User.all
    end

    def get_user(id:)
      User.find(id)
    end

    def get_pairings
      Pairing.all
    end

    def get_pairing(id:)
      # require "pry"; binding.pry
      Pairing.find(id)
    end

    def skills
      Skill.all
    end
  end
end
