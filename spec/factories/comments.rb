# == Schema Information
#
# Table name: comments
#
#  id          :integer(4)      not null, primary key
#  author      :string(255)
#  content     :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  parent_id   :integer(4)
#  parent_type :string(255)
#

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    author "MyString"
    content "MyString"
  end
end
