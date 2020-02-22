class MessageGenerator
  def pairing_notification(name, date, time)
    "#{name} has booked a pairing session with you from #{times[time]} " +
    "on #{date_formatter(date)} using Paired! Visit " +
    "http://paired.tech/schedule to view this booking."
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
end
