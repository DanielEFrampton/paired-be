module Mutations
  module Users
    class UpdateUser < ::Mutations::BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :email, String, required: false
      argument :image, String, required: false
      argument :module, Integer, required: false, as: :mod
      argument :program, String, required: false
      argument :pronouns, String, required: false
      argument :slack, String, required: false
      argument :phone_number, String, required: false
      argument :firebase_i_d, String, required: false
      argument :skills, [String], required: false

      type Types::UserType

      def resolve(attributes)
        new_skills = attributes.delete(:skills)
        attributes[:firebase_id] =  attributes.delete :firebase_i_d
        user = User.where(id: attributes[:id]).first
        user.update(attributes)

        old_skills = user.skills

        if new_skills # necessary because updateUser is used by updateImage
          new_skills.each_with_index do |new_skill, index|
            unless new_skill == old_skills[index].name
              old_skills[index].update(name: new_skill)
            end
          end
        end
        user
      end
    end
  end
end
