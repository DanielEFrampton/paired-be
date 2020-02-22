module Mutations
  module Users
    class CreateUser < ::Mutations::BaseMutation
      argument :user, Types::UserType, required: true
      argument :name, String, required: true
      argument :email, String, required: true
      argument :image, String, required: true
      argument :mod, String, required: true
      argument :program, String, required: true
      argument :pronouns, String, required: true
      argument :slack, String, required: true
      argument :phone_number, String, required: true

      type Types::UserType

      def resolve(attributes)
require "pry"; binding.pry
        User.create(attributes)
      end
    end
  end
end
