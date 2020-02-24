module Mutations
  module Pairings
    class UpdatePairing < ::Mutations::BaseMutation
      argument :id, ID, required: true
      argument :pairee_id, Integer, required: true
      argument :notes, String, required: false

      type Types::PairingType

      def resolve(attributes)
        require "pry"; binding.pry
        pairing = Pairing.find(id)
      end
    end
  end
end
