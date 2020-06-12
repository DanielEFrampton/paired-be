class SmsService
  def send_sms(contact_info, message, type)
    message_data = serialize_message_data(phone_number, message)
    response = send_request(message_data)
    response_body = JSON.parse(response.body)
    OutgoingSmsCommunication.record(address, response_body['response'], type)
    response_body
  end

  private

    def serialize_message_data(phone_number, message)
      JSON.generate(
        phone_number: phone_number,
        message: message,
        sms_token: ENV['TWILIO_SERVICE_TOKEN']
      )
    end

    def send_request(message_data)
      connection.post('/request') do |request|
        request.body = message_data
      end
    end

    def connection
      Faraday.new(url: 'https://paired-sms.herokuapp.com') do |f|
        f.adapter Faraday.default_adapter
      end
    end
end
