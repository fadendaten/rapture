class Customer < ActiveRecord::Base
  attr_accessible :company, :phone, :mobile, :fax, :email, :language, :homepage
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  homepage_regex = /https?:\/\/(\w+\.)+[a-z]+/i
  
  validates :company,  :presence => :true,
                       :uniqueness => { :case_sensitive => true }
  validates :phone,    :presence => :true,
                       :length   => { :within => 10..15 }
  validates :mobile,   :length   => { :within => 10..15 }
  validates :fax,      :length   => { :within => 10..15 }
  validates :email,    :format   => { :with   => email_regex }
  validates :homepage, :format   => { :with   => homepage_regex }
                      
end
