class SmsWorker
  include SideKiq::Worker
  sidekiq_options retry: false

  def perform(phone_number, message)
    SmsService.send_sms(phone_number, message)
  end
end
