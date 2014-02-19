# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    description "MyText"
    starttime "2014-02-19 16:16:58"
    endtime "2014-02-19 16:16:58"
    status "MyString"
  end
end
