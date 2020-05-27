FactoryBot.define do
  factory :rock_and_pebble do
    rock { create :user }
    pebble { create :user }
    active { false }
  end
end
