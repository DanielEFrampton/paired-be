module Mutations
  module RockAndPebbles
    class CreateRockPebbleRelationship < ::Mutation::BaseMutation
      argument :rock_id, required: true
      argument :pebble_id, required: true
      type Types::RockAndPebbleType

      def resolve(attributes)
        new_rp = RockAndPebble.create(
          rock_id: attributes[:rock_id],
          pebble_id: attributes[:pebble_id]
        )

        send_confirmation_email(new_rp)
        return new_rp 
      end

      private

      def send_confirmation_email(new_rp)
        info = new_rp.rock_pebble_info
        NotificationsWorker.rock_pebble_message(info, nil, :confirmation_message)
      end
    end
  end
end
