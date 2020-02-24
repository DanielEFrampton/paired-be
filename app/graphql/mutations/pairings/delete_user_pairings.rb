module Mutations
  module Pairings
    class DeleteUserPairings < ::Mutations::BaseMutation
      argument :id, ID, required: true

      type Types::PairingType

      def resolve(attributes)
        id = attributes[:id]
        userpairings = Pairing.where(pairer_id: id)
        userpairings.destroy_all
      end
    end
  end
end
