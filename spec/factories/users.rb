# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "MyString"
    last_name "MyString"
    address "MyString"
    home_phone "MyString"
    availablity_time "MyString"
    best_time_to_call "MyString"
    date_of_birth "2013-12-17 15:00:18"
  end
end
