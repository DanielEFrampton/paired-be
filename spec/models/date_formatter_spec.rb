require 'rails_helper'

RSpec.describe DateFormatter do
  describe 'formats datetime object to conform with format of appointment dates in database' do
    it 'works' do
      date_1 = Time.parse("9/11/2019")
      date_2 = Time.parse("21/01/2020")
      formatted_date_1 = DateFormatter.format(date_1)
      formatted_date_2 = DateFormatter.format(date_2)

      expect(formatted_date_1).to eq('Sat Nov 09 2019')
      expect(formatted_date_2).to eq('Tue Jan 21 2020')
    end
  end
end
