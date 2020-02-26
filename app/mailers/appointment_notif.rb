class AppointmentNotif < ApplicationMailer
  def initial_message(pairing)
    @message = MessageGenerator.new.pairing_notification(pairing.pairee_name, pairing.date, pairing.time)
    mail(to: pairing.pairer_email, subject: "You have a new pairing booked!")
  end
end
