module Mutations
  module Users
    class CreateUser < ::Mutations::BaseMutation
      argument :name, String, required: true
      argument :program, String, required: true
      argument :mod, String, required: true

      type Types::UserType

      def resolve(attributes)
require "pry"; binding.pry
        User.create(attributes)
      end
    end
  end
end
