    # Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mentee do
    donor_id "D1522175"
    first_name "CONNIE"
    last_name "JONES"
    email "connie@email.com"
    home_phone "9519272040"
    availability "Evening"
    prophecy "I place a creative anointing upon you that shall"
    bc "bc2"
  end
end
