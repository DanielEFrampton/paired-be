module Mutations
  module Pairings
    class CreatePairings < ::Mutations::BaseMutation
      argument :pairings, [Types::PairingAttributesType], required: true
      type Types::UserType

      def resolve(attributes)
        pairer = User.find_by(firebase_id: attributes[:pairings][0][:pairer])
        pairings = attributes[:pairings].map do |pairing|
          data = pairing.to_h
          Pairing.create(pairer: pairer, date: data[:date], time: data[:time])
        end
        pairer
      end
    end
  end
end
