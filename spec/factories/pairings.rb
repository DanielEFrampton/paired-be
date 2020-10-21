FactoryBot.define do
  factory :pairing do
    pairer { create :user }
    pairee { create :user }
    time { ['morning', 'lunch', 'afternoon'].sample }
    date { (DateTime.now + rand(20)).strftime('%a %b %d %Y') }

    factory :past_pairing do
      date { (DateTime.now - rand(50)).strftime('%a %b %d %Y') }
    end

    factory :pairing_with_notes do
      notes { Faker::Hacker.say_something_smart }
    end
  end
end
