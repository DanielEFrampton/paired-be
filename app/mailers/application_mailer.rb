class ApplicationMailer < ActionMailer::Base
  default from: 'no_reply@paired.tech'
  layout 'mailer'

  def record_outgoing_message(recip_address, response_status, response_body, message_type)
    user = User.find_by(email: recip_address)
    OutgoingEmailCommunication.create(
      user: user,
      response_status: response_status,
      response_body: response_body,
      message_type: message_type,
      created_at: Time.now
    )
  end
end
