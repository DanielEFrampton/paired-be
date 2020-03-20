class Pairing < ApplicationRecord
  belongs_to :pairer, class_name: 'User'
  belongs_to :pairee, class_name: 'User', optional: true

  def self.send_reminders(time)
    pairings = today_at(time)
    message = MessageGenerator.new.pairing_reminder(time)
    type = :reminder_message
    pairings.each do |pairing|
      contact_info = pairing.pairer_contact_info
      NotificationsWorker.perform_later(contact_info, message, type)
    end
  end

  def self.today_at(time)
    todays_date = DateFormatter.format(Time.now)
    where(date: todays_date, time: time).
    where.not(pairee_id: nil)
  end

  def pairer_email
    pairer.email
  end

  def pairee_email
    pairee.email
  end

  def pairer_name
    pairer.name
  end

  def pairee_name
    pairee.name
  end

  def pairer_phone_number
    pairer.phone_number
  end

  def pairer_name
    pairer.name
  end

  def pairee_phone_number
    pairee.phone_number
  end

  def pairer_contact_info
    {phone_number: pairer_phone_number,
     email_address: pairer_email
    }
  end

  def pairee_contact_info
    {phone_number: pairee_phone_number,
     email_address: pairee_email
    }
  end
end
