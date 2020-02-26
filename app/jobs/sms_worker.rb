class SmsWorker < ActiveJob::Base
  sidekiq_options retry: false
  queue_as :default

  def perform(phone_number, message)
    SmsService.new.send_sms(phone_number, message)
  end
end
