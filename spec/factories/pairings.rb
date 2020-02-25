FactoryBot.define do
  factory :pairing do
    pairer {create :user}
    pairee {create :user}
    time { 'lunch' }
    date { 'Wed Apr 03 2020'}
  end
end
