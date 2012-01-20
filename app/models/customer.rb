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
  
  # TODO: Refactor into modules and eradicate duplicated code
  
  has_one  :contact_address,  :as => :parent, :dependent => :destroy
  has_one  :invoice_address,  :as => :parent, :dependent => :destroy
  has_one  :delivery_address, :as => :parent, :dependent => :destroy
  has_many :comments,         :as => :parent, :dependent => :destroy
  
  accepts_nested_attributes_for :contact_address,  :reject_if => lambda { |a| a[:line_1].blank? }
  accepts_nested_attributes_for :invoice_address,  :reject_if => lambda { |a| a[:line_1].blank? }
  accepts_nested_attributes_for :delivery_address, :reject_if => lambda { |a| a[:line_1].blank? }
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  homepage_regex = /https?:\/\/(\w+\.)+[a-z]+/i
  
  validates :company,  :presence   => :true,
                       :uniqueness => { :case_sensitive => true }
  validates :phone,    :presence => :true,
                       :length   => { :within => 10..30 }
  validates :mobile,   :length => { :within => 10..30 },
                       :if     => :mobile?
  validates :fax,      :length => { :within => 10..30 },
                       :if     => :fax?
  validates :email,    :format => { :with   => email_regex },
                       :if     => :email? 
  validates :homepage, :format => { :with   => homepage_regex },
                       :if     => :homepage?
                       
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
    found_customers = find(:all, :conditions => ['LOWER(company) LIKE ? OR LOWER(phone) LIKE ?', search_condition, search_condition])
    
    # sort mechanism: sorts results, ones that start with the search string are presented first,
    # and results where the search string is somewhere in the result are presented afterwards.
    start_with_query = Array.new
    found_customers.each do |found|
      start_with_query.push(found) if found.company.start_with?(search)
    end
    found_customers.sort!
    start_with_query.sort!
    start_with_query | found_customers
  end
  

end

