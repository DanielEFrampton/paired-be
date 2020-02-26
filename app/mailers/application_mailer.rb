class ApplicationMailer < ActionMailer::Base
  default from: 'no_reply@paired.tech'
  layout 'mailer'
end
