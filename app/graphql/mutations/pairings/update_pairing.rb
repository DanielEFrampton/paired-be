module Mutations
  module Pairings
    class UpdatePairing < ::Mutations::BaseMutation
      argument :id, ID, required: true
      argument :pairee, String, required: true
      argument :notes, String, required: false

      type Types::PairingType

      def resolve(attributes)
        pairing = Pairing.find(attributes[:id])
        pairing.update(
          pairee_id: attributes[:pairee],
          notes: attributes[:notes],
        )
        notifications(pairing)
        pairing
      end

      private

      def create_message(pairing)
        name = pairing.pairee_name
        date = pairing.date
        time = pairing.time
        MessageGenerator.new.pairing_notification(name, date, time)
      end

      def notifications(pairing)
        message = create_message(pairing)
        contact_info = pairing.pairer_contact_info
        NotificationsWorker.perform_later(
          contact_info,
          message,
          :initial_message,
        )
      end
    end
  end
end
