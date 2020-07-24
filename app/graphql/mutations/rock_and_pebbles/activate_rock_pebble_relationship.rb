module Mutations
  module RockAndPebbles
    class ActivateRockPebbleRelationship < ::Mutations::BaseMutation
      argument :id, ID, required: true
      type Types::RockAndPebbleType

      def resolve(attributes)
        rock_and_pebble = RockAndPebble.find(attributes[:id])
        send_pebble_confirmation_email(rock_and_pebble)
        rock_and_pebble.update(active: true)
        rock_and_pebble
      end

      private

      def send_pebble_confirmation_email(rock_and_pebble)
        info = rock_and_pebble.rock_pebble_info
        NotificationsWorker.rock_pebble_message(info, :rock_accepted_message)
      end
    end
  end
end

