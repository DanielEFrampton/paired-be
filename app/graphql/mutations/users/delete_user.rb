module Mutations
  module Users
    class DeleteUser < ::Mutations::BaseMutation
        argument :id, ID, required: true

      type Types::UserType

      def resolve(attributes)
        id = attributes[:id]
        user = User.find(id)
        user.destroy
      end
    end
  end
end
