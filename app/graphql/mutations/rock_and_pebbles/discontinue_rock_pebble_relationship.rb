module Mutations
    module RockAndPebbles
      class DiscontinueRockPebbleRelationship < ::Mutations::BaseMutation
        argument :id, ID, required: true
        argument :reason, String, required: true
        argument :userId, ID, required: true
        type Types::RockAndPebbleType

        def resolve(attributes)
          rock_and_pebble = RockAndPebble.find(attributes[:id])
          send_pebble_email(rock_and_pebble, attributes)

          rock_and_pebble.update(active: false)
          rock_and_pebble
        end

        private

        def send_pebble_email(rock_and_pebble, attributes)
          user = User.find(attributes[:user_id])
          if user.id == rock_and_pebble.rock_id
            reason = attributes[:reason]
            info = rock_and_pebble.rock_pebble_info
            NotificationsWorker.rock_pebble_message(info, reason, :rock_relationship_discontinued)
          else
            reason = attributes[:reason]
            info = rock_and_pebble.rock_pebble_info
            NotificationsWorker.rock_pebble_message(info, reason, :pebble_relationship_discontinued)
          end
        end
      end
    end
  end
