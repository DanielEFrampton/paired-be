class OutgoingSmsCommunication < ApplicationRecord
  belongs_to :user

  enum message_type: [
    :initial_message,
    :cancellation_message,
    :reminder_message
  ]

  def self.create(recip_email, status, type)
    user = User.find_by(email: recip_email)
    msg_type = message_types[type]

    super(
      user: user,
      status: status,
      message_type: msg_type
    )
  end

end
