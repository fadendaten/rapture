class Customer < ActiveRecord::Base
  attr_accessible :company, :phone, :mobile, :fax, :email, :language, :homepage
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  homepage_regex = /https?:\/\/(\w+\.)+[a-z]+/i
  
  validates :company,  :presence   => :true,
                       :uniqueness => { :case_sensitive => true }
  validates :phone,    :presence => :true,
                       :length   => { :within => 10..15 }
  validates :mobile,   :length => { :within => 10..15 },
                       :if     => :mobile?
  validates :fax,      :length => { :within => 10..15 },
                       :if     => :fax?
  validates :email,    :format => { :with   => email_regex },
                       :if => :email? 
  validates :homepage, :format => { :with   => homepage_regex },
                       :if => :homepage?
  
  def to_s
    company
  end
                      
end
