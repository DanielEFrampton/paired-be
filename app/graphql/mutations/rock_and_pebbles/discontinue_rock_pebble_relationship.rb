module Mutations
  module RockAndPebbles
    class DiscontinueRockPebbleRelationship < ::Mutations::BaseMutation
      argument :rock_id, ID, required: true
      argument :pebble_id, ID, required: true
      argument :reason, String, required: true
      argument :userRelationship, String, required: true
      type Types::UserType

      def resolve(attributes)
        rock_and_pebble =
          RockAndPebble
            .where(rock_id: attributes[:rock_id])
            .where(pebble_id: attributes[:pebble_id])
            .where(active: true)
            .first
        send_pebble_email(rock_and_pebble, attributes)

        rock_and_pebble.update(active: false)
        if attributes[:user_relationship] == "pebble"
          User.find_by(id: attributes[:rock_id])
        else
          User.find_by(id: attributes[:pebble_id])
        end
      end

      private

      def send_pebble_email(rock_and_pebble, attributes)
        reason = attributes[:reason]
        info = rock_and_pebble.rock_pebble_info
        if attributes[:user_relationship] == "pebble"
          NotificationsWorker.rock_pebble_message(
            info,
            reason,
            :pebble_relationship_discontinued,
          )
        else
          NotificationsWorker.rock_pebble_message(
            info,
            reason,
            :rock_relationship_discontinued,
          )
        end
      end
    end
  end
end
