FactoryBot.define do
  factory :task do
    title       { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    status      { :pending }
    due_date    { Faker::Date.forward(days: 20) }
    association :user
  end
end
