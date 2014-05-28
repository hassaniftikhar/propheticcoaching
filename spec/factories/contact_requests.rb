# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact_request do
    subject "MyString"
    first_name "MyString"
    last_name "MyString"
    email "MyString"
    phone_no "MyString"
    contact_mode "MyString"
    city "MyString"
    state_country "MyString"
    website "MyString"
    heard_mode "MyString"
    purpose "MyString"
    message "MyText"
  end
end
