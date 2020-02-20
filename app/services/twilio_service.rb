class TwilioService

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
end
