class TwilioService
  def appointment_request(name, phone_number, time)
    send_request('/request', name, phone_number, time)
  end

  private
    def connection
      Faraday.new(url: 'https://paired-sms.herokuapp.com') do |f|
        f.adapter = default_adapter
      end
    end

    def generate_request(name, phone_number, time)
      data = {
        name: name,
        phone_number: phone_number,
        time: time,
        sms_token: ENV['TWILIO_SERVICE_TOKEN']
      }

      data.to_json
    end

    def send_request(url, name, phone_number, time)
      response = connection.post do |request|
        request.url = url
        request.body = generate_request(name, phone_number, time)
      end
      response
    end
end
