class MessageGenerator
  def pairing_notification(name, date, time)
    "#{name} has booked a pairing session with you from #{times[time]} " +
    "on #{date_formatter(date)} using Paired! " +
    "View it at #{paired_link}."
  end

  def pairing_reminder(time)
    "Friendly reminder that you have a pairing booked today from #{times[time]}. " +
    "View it at #{paired_link}"
  end 

  def cancel_notification(name, date, time)
    "#{name} has cancelled a pairing session with you from #{times[time]} " +
    "on #{date_formatter(date)}. Keep pairing!"
  end

  private

  def times
    {
      'morning' => '8:00-8:30am',
      'lunch' => '12:00-12:30pm',
      'afternoon' => '4:10-4:40pm'
    }
  end

  def date_formatter(date)
    ruby_date = Date.parse(date)
    ruby_date.strftime("%A, %B #{ruby_date.day.ordinalize}")
  end

  def paired_link
    'https://www.paired.tech'
  end
end
