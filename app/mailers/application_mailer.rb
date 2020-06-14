class ApplicationMailer < ActionMailer::Base
  default from: 'no_reply@paired.tech'
  layout 'mailer'

  def record_outgoing_message(recip_address, mail_obj, message_type)
    user = User.find_by(email: recip_address)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail_obj.to_json)

    OutgoingEmailCommunication.create(
      user: user,
      response_status: response.status_code,
      response_body: response.body,
      message_type: message_type,
      created_at: Time.now
    )
  end
end
