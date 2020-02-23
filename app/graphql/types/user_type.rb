module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :mod, String, null: false
    field :program, String, null: false
    field :pronouns, String, null: false
    field :slack, String, null: false
    field :email, String, null: false
    field :image, String, null: false
    field :phone_number, String, null: false
    field :firebase_id, String, null: false
    field :skills, [String], null: true

    def skills
      object.skills.map do |skill|
        skill.name
      end
    end
  end
end
