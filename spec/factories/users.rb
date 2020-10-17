FactoryBot.define do
  factory :user do
    name {Faker::FunnyName.name }
    mod { Faker::Number.within(range: 1..5) }
    program { ['BE', 'FE'].sample }
    pronouns { ['She/her/hers', 'He/him/his', 'They/them/their'].sample }
    slack { '@' + name.downcase.delete(' ') }
    email { Faker::Internet.email }
    image { "https://robohash.org/#{name.downcase.delete(' ')}.png?size=200x200" }
    phone_number { '5555550100' }
    firebase_id { Faker::Alphanumeric.alphanumeric(number: 28 ) }

    factory :user_random_opt_in do
      rock_opt_in { [true, false].sample }
    end
  end
end
