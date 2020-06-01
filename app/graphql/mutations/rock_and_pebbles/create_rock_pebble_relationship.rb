module Mutations
  module RockAndPebbles
    class CreateRockPebbleRelationship < ::Mutation::BaseMutation
      argument :rock_id, required: true
      argument :pebble_id, required: true
      type Types::RockAndPebbleType

      def resolve(attributes)
        new_rp = RockAndPebble.create(
          rock_id: attributes[:rock_id],
          pebble_id: attributes[:pebble_id],
        )
      end
    end
  end
end
