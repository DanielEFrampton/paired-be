desc 'Test the sendgrid status api call'
task :test_sendgrid_status_response => :environment do
  AppointmentNotif.initial_message(ENV['TEST_EMAIL_ADDRESS'], 'Hello')
  outgoing_email = OutgoingEmailCommunication.last
  unless outgoing_email.response_status == 200
    raise 'An exception occured while attempting to send a message to sendgrid'
  end
  OutgoingEmail.destroy_all   
end
