# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :featured_product do
    title "MyString"
    description "MyText"
    image "MyString"
    price "9.99"
    profile_id "MyString"
    profile_type "MyString"
  end
end
