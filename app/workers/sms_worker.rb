class SmsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(phone_number, message)
    SmsService.new.send_sms(phone_number, message)
  end
end
