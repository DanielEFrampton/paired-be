class OutgoingSmsCommunication < ApplicationRecord
  belongs_to :user

  enum type: [
    :initial_message,
    :cancellation_message,
    :reminder_message
  ]

  def self.record(recip_email, status, type)
    user = User.find_by(email: recip_email)
    msg_type = type_map[type]

    create(
      user: user,
      status: status,
      type: msg_type
    )
  end

  def self.type_map
    {
      initial_message: 0,
      cancellation_message: 1,
      reminder_message: 2
    }
  end
end
