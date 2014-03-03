# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :email_history do
    body "MyText"
    mentee_id 1
  end
end
