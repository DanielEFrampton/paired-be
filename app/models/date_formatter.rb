class DateFormatter
  def self.format(date)
    dtime = date.to_date.asctime.gsub("00:00:00 ", "")
    dtime[8] = '0' if dtime[8] == ' '
    dtime
  end
end
