module Mutations
  module Users
    class DeleteUser < ::Mutations::BaseMutation
      argument :id, ID, required: true

      type Types::UserType

      def resolve(attributes)
        id = attributes[:id]
        delete_pairings(id)

        user = User.find(id)
        user.destroy
      end
private
      def delete_pairings(id)
        pairings = Pairing.where('pairer_id = ? AND pairee_id IS NULL', id)
        pairings.destroy_all if pairings.any?
      end
    end
  end
end
