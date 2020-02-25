class AppointmentNotif < ApplicationMailer
  def initial_message(pairing)
    @pairing = pairing

    mail(to: @pairing.pairer_email, subject: "You have a new pairing booked!")
  end

  def reminder_message(pairing)
    @pairer = pairing.pairer
    @pairee = pairing.pairee

    mail(to: @pairer.email, subject: "You have a pairing in one hour!")
  end
end
