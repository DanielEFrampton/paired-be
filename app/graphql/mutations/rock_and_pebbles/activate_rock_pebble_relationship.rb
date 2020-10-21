module Mutations
  module RockAndPebbles
    class ActivateRockPebbleRelationship < ::Mutations::BaseMutation
      argument :rock_id, ID, required: true
      argument :pebble_id, ID, required: true
      type Types::UserType

      def resolve(attributes)
        rock_and_pebble = RockAndPebble.where(rock_id: attributes[:rock_id]).where(pebble_id: attributes[:pebble_id]).where(pending: true).first
        send_pebble_confirmation_email(rock_and_pebble)
        rock_and_pebble.update(active: true, pending: false)
        User.find_by(id: attributes[:rock_id])
      end

      private

      def send_pebble_confirmation_email(rock_and_pebble)
        info = rock_and_pebble.rock_pebble_info
        NotificationsWorker.rock_pebble_message(info, :rock_accepted_message)
      end
    end
  end
end

