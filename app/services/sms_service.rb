class SmsService
  def send_sms(phone_number, message)
    message_data = serialize_message_data(phone_number, message)
    send_request(message_data)
  end

  private

    def serialize_message_data(phone_number, message)
      data = {
        phone_number: phone_number,
        message: message,
        sms_token: ENV['TWILIO_SERVICE_TOKEN']
      }
      JSON.generate(data)
    end

    def send_request(message_data)
      response = connection.post('/request') do |request|
        request.body = message_data
      end
      response
    end

    def connection
      Faraday.new(url: 'https://paired-sms.herokuapp.com') do |f|
        f.adapter Faraday.default_adapter
      end
    end
end
