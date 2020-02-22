module Types
  class SkillType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false

    field :user, Types::UserType, null: false
  end
end
