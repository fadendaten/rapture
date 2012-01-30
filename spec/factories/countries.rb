# == Schema Information
#
# Table name: countries
#
#  id         :integer(4)      not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :country do
  end
end
