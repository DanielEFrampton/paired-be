module Mutations
  module Users
    class UpdateUserOptinStatus < ::Mutations::BaseMutation
      argument :id, ID, required: true

      type Types::UserType

      def resolve(attributes)
        user = User.where(id: attributes[:id]).first
        !user.rock_opt_in ? user.update(rock_opt_in: true) : user.update(rock_opt_in: false)
        user
      end
    end
  end
end
