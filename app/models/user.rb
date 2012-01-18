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
  
  attr_accessor   :password
  attr_accessible :username, :email, :password, :first_name, :last_name
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :username, :presence => true,
                       :length   => { :maximum => 15 }
  validates :email,    :presence   => true,
                       :format     => { :with => email_regex },
                       :uniqueness => { :case_sensitive => false }
  validates :password, :presence     => true,
                       :length       => { :within => 6..40 }
                       
  before_save :encrypt_password

  def self.authenticate(username, submitted_password)
    user = User.find_by_username(username)
    (user && user.encrypted_password == Digest::SHA2.hexdigest("#{user.salt}--#{submitted_password}")) ? user : nil
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = User.find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  def name
    "#{first_name} #{last_name}"
  end

  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

end

