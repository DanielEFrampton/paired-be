FactoryBot.define do
  factory :user do
    name {Faker::FunnyName.name}
    mod { "Mod 3" }
    program { "BE" }
    pronouns { "She/her" }
    slack  {Faker::FunnyName.name}
    email { Faker::Internet.email }
    image { Faker::LoremFlickr.image }
    phone_number { "4233162121" }
    firebase_id {'lmfao1233444'}
  end
end
