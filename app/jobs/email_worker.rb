class EmailWorker < ActiveJob::Base
  sidekiq_options retry: false
  queue_as :default

  def perform(pairing)
    AppointmentNotif.initial_message(pairing).deliver_now
  end
end
