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

class User < ActiveRecord::Base
  
  devise :database_authenticatable, :recoverable, :rememberable, :trackable
  attr_accessible :username, :email, :password, :password_confirmation, :first_name, :last_name, :remember_me
  
  has_many :user_role_assignments
  has_many :user_roles, :through => :user_role_assignments
  
  validates :username,   :presence => true,
                         :length   => { :within => 4..40 },
                         :uniqueness => true
  validates :email,      :presence   => true,
                         :format     => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password,   :presence     => true,
                         :confirmation => true,
                         :length       => { :within => 6..40 },
                         :if           => :password_validation_required?
  validates :first_name, :presence => true
  validates :last_name,  :presence => true
  
  def self.build(attributes)
    user = User.new
    self.set_info(user, attributes)
    user.password = generate_new_password
    user
  end
  
  def self.generate_new_password
    "test123"
  end
  
  def set_attributes(attributes)
    User.set_info(self, attributes)
    unless attributes[:password].blank?
      self.password = attributes[:password]
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end
  
  def has_role?(role_sym)
    self.user_roles.any? {
      |role| role.name.underscore.to_sym == role_sym
    }
  end
  
  private
  
    def self.set_info(user, attributes)
      user.username = attributes[:username]
      user.first_name = attributes[:first_name]
      user.last_name = attributes[:last_name]
      user.email = attributes[:email]
      user.user_roles.clear
      unless attributes[:user_role_ids].nil?
        attributes[:user_role_ids].each do |id|
          unless id.blank?
            user.user_roles << UserRole.find(id)
          end
        end
      end
    end
    
    def password_validation_required?
      self.encrypted_password.blank?
    end
   
end
