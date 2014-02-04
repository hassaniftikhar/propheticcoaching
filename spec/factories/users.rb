FactoryGirl.define do
  factory :user do
    first_name "test"
    last_name "user"
    email "test_user@email.com"
    password "testing111"
    password_confirmation "testing111"
  end
end