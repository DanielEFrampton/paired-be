module Mutations
  module Users
    class UpdateUser < ::Mutations::BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :email, String, required: false
      argument :image, String, required: false
      argument :module, String, required: false, as: :mod
      argument :program, String, required: false
      argument :pronouns, String, required: false
      argument :slack, String, required: false
      argument :phone_number, String, required: false
      argument :firebase_i_d, String, required: false
      argument :skills, [String], required: false

      type Types::UserType

      def resolve(attributes)
        new_skills = attributes.delete(:skills)

        user = User.where(id: attributes[:id]).first
        user.update(attributes)

        old_skills = user.skills

        new_skills.each.with_index do |new_skill, new_i|
          old_skills.each.with_index do |old_skill, old_i|
            old_skill.update(name: new_skill) if new_i == old_i && !new_skill.empty?
          end
        end
        user
      end
    end
  end
end
