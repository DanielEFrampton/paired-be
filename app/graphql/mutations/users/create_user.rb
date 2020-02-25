module Mutations
  module Users
    class CreateUser < ::Mutations::BaseMutation
      argument :name, String, required: true
      argument :email, String, required: true
      argument :image, String, required: true
      argument :module, String,
               required: true,
               as: :mod
      argument :program, String, required: true
      argument :pronouns, String, required: true
      argument :slack, String, required: true
      argument :phone_number, String, required: true
      argument :firebase_i_d, String, required: true
      argument :skills, [String], required: false

      type Types::UserType

      def resolve(attributes)
        skills = attributes.delete(:skills)
        user = User.create(attributes)
        skills.each do |skill|
          user.skills.create(name: skill)
        end
        user
      end
    end
  end
end
