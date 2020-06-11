class AppointmentNotif < ApplicationMailer
  def initial_message(address, message)
    @message = message
    mail_obj = mail(to: address, from: 'bookings@paired.tech', subject: "You have a new pairing booked!")
    record_outgoing_message(address, mail_obj, 0)
  end

  def reminder_message(address, message)
    @message = message
    mail_obj = mail(to: address, from: 'bookings@paired.tech', subject: "You have a pairing today!")
    record_outgoing_message(address, mail_obj, 1)
  end

  def cancel_message(address, message)
    @message = message
    mail_obj = mail(to: address, from: 'bookings@paired.tech', subject: "Your pairing has been canceled. :(")
    record_outgoing_message(address, mail_obj, 2)
  end
end
