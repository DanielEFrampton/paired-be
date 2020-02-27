module Mutations
  module Pairings
    class CreatePairings < ::Mutations::BaseMutation
      argument :pairings, [Types::PairingAttributesType], required: true
      type Types::PairingType

      def resolve(attributes)
        pairer_id = attributes[:pairings][0][:pairer]
        pairer = User.find(pairer_id)
        pairings = attributes[:pairings].map do |pairing|
          data = pairing.to_h
          Pairing.create(pairer: pairer, date: data[:date], time: data[:time])
        end
        pairer
      end
    end
  end
end
