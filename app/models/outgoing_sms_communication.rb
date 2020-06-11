class OutgoingSmsCommunication < ApplicationRecord
  belongs_to :user

  enum type: [
    :initial_message,
    :cancellation_message,
    :reminder_message
  ]

  def self.type_map
    {
      initial_message: 0,
      cancellation_message: 1,
      reminder_message: 2
    }
  end
end
