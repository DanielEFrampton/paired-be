module Mutations
  module Users
    class CreateUser < ::Mutations::BaseMutation
      argument :name, String, required: true
      argument :email, String, required: true
      argument :image, String, required: true
      argument :module, Integer, required: true, as: :mod
      argument :program, String, required: true
      argument :pronouns, String, required: true
      argument :slack, String, required: true
      argument :phone_number, String, required: true
      argument :firebase_i_d, String, required: true
      argument :skills, [String], required: false

      type Types::UserType

      def resolve(attributes)
        skills = attributes.delete(:skills)
        attributes[:firebase_id] = attributes.delete :firebase_i_d
        user = User.create(attributes)
        skills.each { |skill| user.skills.create(name: skill) }
        user
      end
    end
  end
end
