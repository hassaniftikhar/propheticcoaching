# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |u|
    u.first_name "test"
    u.last_name "user"
    u.sequence(:email) {|n| "test_#{n}@email.com"}
    #email "test_user@email.com"
    u.password "testing111"
    u.password_confirmation "testing111"
  end
end
