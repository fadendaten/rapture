# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    line_1 "MyString"
    line_2 "MyString"
    line_3 "MyString"
    zip_code "MyString"
    city "MyString"
    country_code "MyString"
  end
end
