# == Schema Information
#
# Table name: addresses
#
#  id           :integer(4)      not null, primary key
#  line_1       :string(255)
#  line_2       :string(255)
#  line_3       :string(255)
#  zip_code     :string(255)
#  city         :string(255)
#  country_code :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  type         :string(255)
#  customer_id  :integer(4)
#  parent_id    :integer(4)
#  parent_type  :string(255)
#

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
