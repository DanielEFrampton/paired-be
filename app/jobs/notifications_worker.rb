class NotificationsWorker < ActiveJob::Base
  queue_as :default

  def perform(contact_info, message, type)
    address = contact_info[:email_address]
    sms = SmsService.new.send_sms(contact_info, message, type)
    AppointmentNotif.send(type, address, message).deliver_now unless sms['response'] == 'success'
  end

  def self.rock_pebble_message(info, reason = nil, type)
    info[:reason] = reason
    RockPebbleMailer.send(type, info).deliver_now
  end
end
