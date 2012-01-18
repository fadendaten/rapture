# == Schema Information
#
# Table name: customers
#
#  id         :integer(4)      not null, primary key
#  company    :string(255)
#  phone      :string(255)
#  mobile     :string(255)
#  fax        :string(255)
#  email      :string(255)
#  language   :string(255)
#  homepage   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Customer < ActiveRecord::Base
  
  paginate_alphabetically :by => :company
  
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
                       
  before_validation :format_homepage_url
  
  def to_s
    company
  end
  
  def format_homepage_url
    unless homepage.blank? || homepage.starts_with?("http://", "https://")
      self.homepage = "http://#{homepage}"
    else
      self.homepage = homepage
    end
  end

  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['company LIKE ? OR phone LIKE ?', search_condition, search_condition])
  end

end

