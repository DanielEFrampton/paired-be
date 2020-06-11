FactoryBot.define do
  factory :outgoing_sms_communication do
    user { nil }
    status { "MyString" }
    type { 1 }
  end
end
