module Mutations
  module RockAndPebbles
    class CreateRockPebbleRelationship < ::Mutation::BaseMutation
      argument :rock_id, required: true
      argument :pebble_id, required: true
      type Types::RockAndPebbleType



    end
  end
end
