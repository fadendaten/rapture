# == Schema Information
#
# Table name: user_role_assignments
#
#  id           :integer(4)      not null, primary key
#  user_id      :integer(4)
#  user_role_id :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_role_assignment do
    user_id 1
    user_role_id 1
  end
end
