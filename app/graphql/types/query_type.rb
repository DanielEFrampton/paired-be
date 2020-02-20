module Types
  class QueryType < Types::BaseObject
    field :users, [Types::UserType], null: false, description: 'Returns a list of users'
    field :skills, [Types::SkillType], null: false, description: 'Returns a list of skills'

    def users
      User.all
    end

    def skills
      Skill.all
    end
  end
end
