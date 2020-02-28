class NotificationsWorker < ActiveJob::Base
  queue_as :default

  def perform(contact_info, message)
    phone_number = contact_info[:phone_number]
    address = contact_info[:email_address]
    response = SmsService.new.send_sms(phone_number, message) if phone_number
    if !phone_number || response['response'] != 'success'
      AppointmentNotif.initial_message(address, message).deliver_now
    end
  end
end
