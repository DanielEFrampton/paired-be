class AppointmentNotif < ApplicationMailer
  def initial_message(address, message)
    @message = message
    mail(to: address, subject: "You have a new pairing booked!")
  end
end
