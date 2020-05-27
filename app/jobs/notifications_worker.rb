class NotificationsWorker < ActiveJob::Base
  queue_as :default

  def perform(contact_info, message, type)
    phone_number = contact_info[:phone_number].to_s
    address = contact_info[:email_address]
    sms = SmsService.new.send_sms(phone_number, message)
    AppointmentNotif.send(type, address, message).deliver_now unless sms['response'] == 'success'
  end

  def self.rock_pebble_message(info, type)
    RockPebbleMailer.send(type, info).deliver_now
  end
end
