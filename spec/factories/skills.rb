FactoryBot.define do
  factory :skill do
    name {Faker::FunnyName.name}

    association :user, factory: :user
  end
end
