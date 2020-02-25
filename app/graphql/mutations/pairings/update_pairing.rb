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
        pairing
        sms_service(pairing)
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

      def sms_service(pairing)
        message = create_message(pairing)
        pairer = User.where(id: pairing.pairer_id).first
        phone_number = pairer.phone_number
        sms = SmsService.new
        sms.send_sms(phone_number, message)
      end
    end
  end
end
