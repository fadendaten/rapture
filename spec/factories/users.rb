# == Schema Information
#
# Table name: users
#
#  id                 :integer(4)      not null, primary key
#  username           :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  first_name         :string(255)
#  last_name          :string(255)
#

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "MyString"
    email "MyString"
  end
end
