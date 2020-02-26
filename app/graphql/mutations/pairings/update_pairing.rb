module Mutations
  module Pairings
    class UpdatePairing < ::Mutations::BaseMutation
      argument :id, ID, required: true
      argument :pairee, Integer, required: true
      argument :notes, String, required: false

      type Types::PairingType

      def resolve(attributes)
        pairing = Pairing.where(id: attributes[:id]).first
        pairing.update(pairee_id: attributes[:pairee], notes: attributes[:notes])
        notifications(pairing)
        pairing
      end

    private

      def create_message(pairing)
        pairee = User.where(id: pairing.pairee_id).first
        name = pairee.name
        date = pairing.date
        time = pairing.time
        message = MessageGenerator.new
        message.pairing_notification(name, date, time)
      end

      def notifications(pairing)
        pairer = User.where(id: pairing.pairer_id).first
        if pairer.phone_number != nil
          message = create_message(pairing)
          phone_number = pairer.phone_number
          sms = SmsService.new
          sms.send_sms(phone_number, message)
        end
      end
    end
  end
end
