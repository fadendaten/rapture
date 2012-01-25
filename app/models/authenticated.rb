module Authenticated
  
  def self.included(base)
    attr_accessor :password
    base.extend ClassMethods
  end
  
  module ClassMethods
    def authenticate(username, submitted_password)
      user = User.find_by_username(username)
      (user && user.encrypted_password == Digest::SHA2.hexdigest("#{user.salt}--#{submitted_password}")) ? user : nil
    end

    def authenticate_with_salt(id, cookie_salt)
      user = User.find_by_id(id)
      (user && user.salt == cookie_salt) ? user : nil
    end
  end
  
  def password_validation_required?
    encrypted_password.blank?
  end
  
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