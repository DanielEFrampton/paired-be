module Mutations
  module RockAndPebbles
    class CreateRockPebbleRelationship < ::Mutations::BaseMutation
      argument :rock_id, ID, required: true
      argument :pebble_id, ID, required: true
      type Types::UserType

      def resolve(attributes)
        new_rp = RockAndPebble.create(
          rock_id: attributes[:rock_id],
          pebble_id: attributes[:pebble_id]
        )

        send_confirmation_email(new_rp)
        User.find_by(id: attributes[:pebble_id])
      end

      private

      def send_confirmation_email(new_rp)
        info = new_rp.rock_pebble_info
        NotificationsWorker.rock_pebble_message(info, nil, :confirmation_message)
      end
    end
  end
end
