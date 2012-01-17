class Customer < ActiveRecord::Base
  
  paginate_alphabetically :by => :company
  
  attr_accessible :company, :phone, :mobile, :fax, :email, :language, :homepage
  
  has_many :addresses, :dependent => :destroy 
  
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
                       
  before_validation :format_homepage_url
  
  def to_s
    company
  end
  
  def format_homepage_url
    unless homepage.blank? || homepage.starts_with?("http://", "https://")
      "http://#{homepage}"
    else
      homepage
    end
  end
                      
end
