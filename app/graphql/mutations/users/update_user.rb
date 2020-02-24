module Mutations
  module Users
    class UpdateUser < ::Mutations::BaseMutation
      argument :id, String, required: true
      # feels weird that this should be returned in the query because id shouldn't change?
      argument :name, String, required: false
      argument :email, String, required: false
      argument :image, String, required: false
      argument :mod, String, required: false
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

        user.update(attributes)

        # old_skills.each do |old_skill|
        #   new_skills.each do |new_skill|
        #     old_skill.update(name: new_skill)
        #   end
        # end
        user
      end
    end
  end
end
