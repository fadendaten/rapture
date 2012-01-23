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
  
  include Accountable
  act_as_addressable
  act_as_customer

  has_many :comments, :as => :parent, :dependent => :destroy
  
  validates :company,  :presence   => :true,
                       :uniqueness => { :case_sensitive => true }
  validates :phone,    :presence => :true,
                       :length   => { :within => 10..30 }
  validates :mobile,   :length => { :within => 10..30 },
                       :if     => :mobile?
  validates :fax,      :length => { :within => 10..30 },
                       :if     => :fax?
  validates :email,    :format => { :with   => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                       :if     => :email? 
  validates :homepage, :format => { :with   => /https?:\/\/(\w+\.)+[a-z]+/i },
                       :if     => :homepage?
                       
  before_validation :format_homepage_url
  
  paginate_alphabetically :by => :company

end

