class NotificationsWorker < ActiveJob::Base
  queue_as :default

  def perform(contact_info, message, type)
    phone_number = contact_info[:phone_number].to_s
    address = contact_info[:email_address]
    sms = SmsService.new.send_sms(phone_number, message)
    AppointmentNotif.send(type, address, message).deliver_now unless sms['response'] == 'success'
  end

  def rock_pebble_confirmation_message(contact_info, type)
    address = contact_info[:email_address]
    name = contact_info[:name]
    RockPebbleMailer.send(type, address, name).deliver_now
  end

  def rock_pebble_termination_message(termination_info, type)
    address = termination_info[:email_address]
    reason = termination_info[:reason]
    RockPebbleMailer.send(type, address, reason).deliver_now
  end
end
