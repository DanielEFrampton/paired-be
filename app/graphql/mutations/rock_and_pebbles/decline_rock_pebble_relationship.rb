module Mutations
  module RockAndPebbles
    class DeclineRockPebbleRelationship < ::Mutations::BaseMutation
      argument :id, ID, required: true
      argument :reason, String, required: true
      type Types::RockAndPebbleType

      def resolve(attributes)
        rock_and_pebble = RockAndPebble.find(attributes[:id])
        send_pebble_email(rock_and_pebble, attributes)

        rock_and_pebble.destroy
      end

      private

      def send_pebble_email(rock_and_pebble, attributes)
        reason = attributes[:reason]
        info = rock_and_pebble.rock_pebble_info

        NotificationsWorker.rock_pebble_message(info, reason, :rock_denied_message)
      end
    end
  end
end
