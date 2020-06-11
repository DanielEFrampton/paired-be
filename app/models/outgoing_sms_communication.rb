class OutgoingSmsCommunication < ApplicationRecord
  belongs_to :user

  enum type: [
    :initial_message,
    :cancellation_message,
    :reminder_message
  ]
end
