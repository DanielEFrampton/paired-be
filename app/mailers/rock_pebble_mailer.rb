class RockPebbleMailer < ApplicationMailer
  def confirmation_message(info)
    address = info[:rock_email]
    name = info[:pebble_name]
    @message = "#{name} has requested you as a Rock through the Rock and Pebble
                feature on Paired.tech. Please visit #{paired_link} to accept or decline
                this request."
    mail_obj = mail(to: address, subject: "Someone has requested you as a Rock!")
    record_outgoing_message(address, mail_obj, 3)
  end

  def rock_accepted_message(info)
    address = info[:pebble_email]
    name = info[:rock_name]
    @message = "#{name} has accepted your Rock request. Please use their contact
                information provided in your Rock & Pebble dashboard at #{paired_link}
                to get in touch with them and say Hi!"
    mail_obj = mail(to: address, subject: "Your Rock request has been accepted!")
    record_outgoing_message(address, mail_obj, 4)
  end

  def rock_denied_message(info)
    address = info[:pebble_email]
    reason = info[:reason]
    name = info[:rock_name]
    @message = "#{name} declined your Rock request. The reason
                given was: #{reason}. Even though this request did not work out
                please go to #{paired_link} and request someone else as your Rock!"
    mail_obj = mail(to: address, subject: "Your Rock request was not accepted.")
    record_outgoing_message(address, mail_obj, 5)
  end

  def pebble_relationship_discontinued(info)
    address = info[:pebble_email]
    reason = info[:reason]
    name = info[:rock_name]
    @message = "#{name} has decided to end your Rock and Pebble relationship.
                The reason given is: #{reason}. Please feel free to follow up with
                any feedback that you may have (always be specific, actionable and kind!)
                or just to say 'Thanks' for the time that they have shared with you. You can go
                to #{paired_link} to sign up for a new Rock at any time!"
    mail_obj = mail(to: address, subject: "Your Rock & Pebble relationship has come to an end.")
    record_outgoing_message(address, mail_obj, 6)
  end

  def rock_relationship_discontinued(info)
    address = info[:rock_email]
    reason = info[:reason]
    name = info[:pebble_name]
    @message = "#{name} has decided to end your Rock and Pebble relationship.
                The reason given is: #{reason}. You can go to #{paired_link}
                if you wish to opt out of being a Rock; otherwise you will
                continue to be displayed on the list of available rocks."
    mail_obj = mail(to: address, subject: "Your Rock & Pebble relationship has come to an end.")
    record_outgoing_message(address, mail_obj, 7)
  end

  def paired_link
    'https://www.paired.tech'
  end
end
