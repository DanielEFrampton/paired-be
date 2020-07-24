FactoryBot.define do
  factory :outgoing_email_communication do
    user { nil }
    response_body { "MyString" }
    response_status { "MyString" }
  end
end
