class AppointmentNotif < ApplicationMailer
  def initial_message(address, message)
    @message = message
    mail(to: address, subject: "You have a new pairing booked!")
  end

  def reminder_message(address, message)
    @message = message
    mail(to: address, subject: "You have a pairing in one hour!")
  end
end
