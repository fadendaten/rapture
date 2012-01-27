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

require 'spec_helper'

  describe User do
    before(:each) do
      @attr = {
        :username => "dummy",
        :email => "dummy@dummy.com",
        :password => "test123",
        :first_name => "dummy",
        :last_name => "dummy"
      }
  end
  
  it "should create a new instance given a valide attribute" do
    User.create!(@attr)
  end
  
  it "should require a username" do
    no_name_user = User.new(@attr.merge(:username => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require an email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject that are too long" do
    long_username = "a" * 41
    long_username_user = User.new(@attr.merge(:username => long_username))
    long_username_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@oo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    invalid_addresses = %w[user@foo,com user_at_foo.bar.org example.user@foo.]
    invalid_addresses.each do |invalid_address|
      invalid_address_user = User.new(@attr.merge(:email => invalid_address))
      invalid_address_user.should_not be_valid
    end
  end
  
  it "should reject duplicate username" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addesses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "passwords" do
    
    before(:each) do
      @user = User.new(@attr)
    end
    
    it "should have a password attribute" do
      @user.should respond_to(:password)
    end
    
    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
    
  end
  
  describe "password validations" do
    
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
      should_not be_valid
    end
    
    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
      should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
    
    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
    
    it "should reject nil as password" do
      User.new(@attr.merge(:password => nil, :password_confirmation => nil))
    end
    
  end
  
  # describe "set_attributes method" do
  #     
  #     before(:each) do
  #       @user = User.create!(@attr)
  #     end
  #     
  #     it "should exist" do
  #       User.should respond_to(:set_attributes)
  #     end
  #     
  #     it "should set new attributes given valid input" do
  #       @user.set_attributes(@attr.merge(:username => "Son Goku"))
  #       @user.save.should be_true
  #     end
  # 
  #     it "should re-encrypt password if it is updated" do
  #       password_before_reencryption = @user.encrypted_password
  #       @user.set_attributes(@attr.merge(:password => "jenkins"))
  #       @user.save
  #       password_before_reencryption.should_not == @user.encrypted_password
  #     end
  #     
  #   end
  
end
