FactoryBot.define do
  factory :skill do
    name { Faker::Superhero.power }

    association :user, factory: :user

    factory :skill_from_dropdown do
      name {
        [
          'grid',
          'flexbox',
          'mythical creatures',
          'react',
          'jsFun',
          'rspec',
          'rails',
          'ruby',
          'jest/enzyme',
          'docker',
          'lightning talks',
          'javascript',
          'css',
          'active record',
          'SQL',
          'sinatra'
        ].sample
      }
    end
  end
end
