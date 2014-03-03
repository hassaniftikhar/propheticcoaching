# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :accomplishment do
    body "MyText"
    mentee_id 1
  end
end
