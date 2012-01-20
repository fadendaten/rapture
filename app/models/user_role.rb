class UserRole < ActiveRecord::Base
  has_many :user_role_assignments
  has_many :users, :through => :user_role_assignments
  
  validates_uniqueness_of :name
end
