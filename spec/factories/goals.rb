# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goal do
    mentee_id 1
    body "MyText"
  end
end
