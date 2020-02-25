FactoryBot.define do
  factory :user do
    name {Faker::FunnyName.name}
    mod { Faker::Number.within(range: 1..4).to_s }
    program { "BE" }
    pronouns { "She/her" }
    slack  {Faker::FunnyName.name}
    email { Faker::Internet.email }
    image { Faker::LoremFlickr.image }
    phone_number { "4233162121" }
    firebase_id { Faker::Alphanumeric.alphanumeric(number: 28 )}
  end
end
