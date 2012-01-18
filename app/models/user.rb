class User < ActiveRecord::Base
  
  attr_accessor   :password
  attr_accessible :username, :email, :password
  
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
