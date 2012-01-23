# == Schema Information
#
# Table name: user_roles
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_role do
    name "admin"
  end
end
