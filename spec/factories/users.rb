# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |user|
    user.username "dummy"
    user.email "dummy@dummy.com"
    user.password "foobar"
    user.first_name "Benjamin"
    user.last_name "Marti"
  end
end
