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
  
  attr_accessible :username, :email, :password, :password_confirmation, :first_name, :last_name, :user_role_ids
  
  validates :username,   :presence => true,
                         :length   => { :within => 4..40 },
                         :uniqueness => true
  validates :email,      :presence   => true,
                         :format     => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password,   :presence => true,
                         :confirmation => true,
                         :length       => { :within => 6..40 }
  validates :first_name, :presence => true
  validates :last_name,  :presence => true
                       
  before_save :encrypt_password
  
  def self.build(attributes)
    user = User.new
    user.username = attributes[:username]
    user.first_name = attributes[:first_name]
    user.last_name = attributes[:last_name]
    user.email = attributes[:email]
    user.password = generate_new_password
    attributes[:user_roles].each { |role| user.user_roles << role }
    user.save!
  end
  
  def generate_new_password
    "test123"
  end

  def full_name
    "#{first_name} #{last_name}"
  end
  
  def has_role?(role_sym)
    self.user_roles.any? {
      |role| role.name.underscore.to_sym == role_sym
    }
  end
  
end

