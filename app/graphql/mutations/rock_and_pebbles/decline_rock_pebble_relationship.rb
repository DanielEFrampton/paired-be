module Mutations
  module RockAndPebbles
    class DeclineRockPebbleRelationship < ::Mutations::BaseMutation
      argument :rock_id, ID, required: true
      argument :pebble_id, ID, required: true
      argument :reason, String, required: true
      type Types::RockAndPebbleType

      def resolve(attributes)
        rock_and_pebble = RockAndPebble.where(rock_id: attributes[:rock_id]).where(pebble_id: attributes[pebble_id]).where(pending: false)
        send_pebble_email(rock_and_pebble, attributes)

        rock_and_pebble.destroy
        rock_and_pebble
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
