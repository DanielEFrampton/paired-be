module Mutations
  module Pairings
    class DeletePairing < ::Mutations::BaseMutation
      argument :id, ID, required: true
      type Types::PairingType

      def resolve(attributes)
        pairing = Pairing.find(attributes[:id])
        pairing.delete
      end
    end
  end
end
