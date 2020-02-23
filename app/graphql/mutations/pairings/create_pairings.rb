module Mutations
  module Pairings
    class CreatePairings < ::Mutations::BaseMutation
      argument :pairer_id, Integer, required: true
      argument :pairee_id, Integer, required: true
      argument :date, String, required: true
      argument :time, String, required: true
      argument :notes, String, required: false

      type Types::PairingType

      def resolve(attributes)
        Pairing.create(attributes)
      end
    end
  end
end
