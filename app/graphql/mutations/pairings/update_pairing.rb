module Mutations
  module Pairings
    class UpdatePairing < ::Mutations::BaseMutation
      argument :id, ID, required: true
      argument :pairee, Integer, required: true
      argument :notes, String, required: false

      type Types::PairingType

      def resolve(attributes)
        pairing = Pairing.find(attributes[:id])
        pairing.update(pairee_id: attributes[:pairee], notes: attributes[:notes])
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
        pairer = pairing.pairer
        pairee = pairing.pairee
        if pairer.phone_number
          phone_number = pairer.phone_number
          SmsWorker.perform_later(phone_number, message)
        else
          EmailWorker.perform_later(pairing)
        end
      end
    end
  end
end
