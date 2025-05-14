FactoryBot.define do
  factory :user do
    name       { Faker::Name.name }
    email     { Faker::Internet.unique.email }
    password  { 'secret123' }
    role      { :user }

    factory :user_with_tasks do
      transient { tasks_count { 3 } }

      after(:create) do |u, evaluator|
        create_list(:task, evaluator.tasks_count, user: u)
      end
    end
  end
end
