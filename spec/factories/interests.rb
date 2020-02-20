FactoryBot.define do
  factory :interest do
    name {Faker::FunnyName.name}

    association :user, factory: :user
  end
end
