class EmailWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(pairing)
    AppointmentNotif.new.initial_message(pairing).deliver_now
  end
end
