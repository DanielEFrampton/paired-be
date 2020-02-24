module Mutations
  module Pairings
    class CreatePairings < ::Mutations::BaseMutation
      argument :pairings, [Types::PairingAttributesType], required: true
      type Types::PairingType
      def resolve(attributes)
        binding.pry
        Pairing.create(attributes)
      end
    end
  end
end
