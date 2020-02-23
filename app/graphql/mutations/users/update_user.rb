module Mutations
  module Users
    class UpdateUser < ::Mutations::BaseMutation
      argument :id, String, required: false
      # feels weird that this should be returned in the query because id shouldn't change?
      argument :name, String, required: false
      argument :email, String, required: false
      argument :image, String, required: false
      argument :mod, String, required: false
      # should this be an integer????
      argument :program, String, required: false
      argument :pronouns, String, required: false
      argument :slack, String, required: false
      argument :phone_number, String, required: false
      argument :firebase_i_d, String, required: false
      argument :skills, [String], required: false

      type Types::UserType

      def resolve(attributes)
        # skills = attributes.delete(:skills)

        # require "pry"; binding.pry
        user = User.update(attributes)
        # skills.each do |skill|
        #   user.skills.create(name: skill)
        # end
        # user
      end
    end
  end
end
