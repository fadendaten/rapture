# == Schema Information
#
# Table name: user_roles
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class UserRole < ActiveRecord::Base
  has_many :user_role_assignments
  has_many :users, :through => :user_role_assignments
  
  validates_uniqueness_of :name
end
