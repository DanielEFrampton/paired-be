class AppointmentNotif < ApplicationMailer
  def initial_message(address, message)
    @message = message
    mail_obj = mail(to: address, from: 'bookings@paired.tech', subject: "You have a new pairing booked!")
  end

  def reminder_message(address, message)
    @message = message
    mail(to: address, from: 'bookings@paired.tech', subject: "You have a pairing today!")
  end

  def cancel_message(address, message)
    @message = message
    mail(to: address, from: 'bookings@paired.tech', subject: "Your pairing has been canceled. :(")
  end
end
