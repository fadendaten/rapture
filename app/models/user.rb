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

class User < ActiveRecord::Base
  
  include Authenticated
  
  has_many :user_role_assignments
  has_many :user_roles, :through => :user_role_assignments
  
  attr_accessible :username, :email, :password, :password_confirmation, :first_name, :last_name
  
  validates :username,   :presence => true,
                         :length   => { :within => 4..40 },
                         :uniqueness => true 
  validates :email,      :presence   => true,
                         :format     => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password,   :presence     => true,
                         :confirmation => true,
                         :length       => { :within => 6..40 }
  validates :first_name, :presence => true
  validates :last_name,  :presence => true
                       
  before_save :encrypt_password

  def full_name
    "#{first_name} #{last_name}"
  end
  
  def has_role?(role_sym)
    self.user_roles.any? {
      |role| role.name.underscore.to_sym == role_sym
    }
  end 

end

