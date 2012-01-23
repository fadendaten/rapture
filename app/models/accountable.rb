module Accountable
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def act_as_addressable
      include AddressableInstanceMethods
    end
    
    def act_as_customer
      include CustomerInstanceMethods
    end
  end
  
  module AddressableInstanceMethods
    def self.included(base)
      base.has_one :contact_address,  :as => :parent, :dependent => :destroy
      base.has_one :invoice_address,  :as => :parent, :dependent => :destroy
      base.has_one :delivery_address, :as => :parent, :dependent => :destroy
      
      base.accepts_nested_attributes_for :contact_address,  :reject_if => lambda { |a| a[:line_1].blank? }
      base.accepts_nested_attributes_for :invoice_address,  :reject_if => lambda { |a| a[:line_1].blank? }
      base.accepts_nested_attributes_for :delivery_address, :reject_if => lambda { |a| a[:line_1].blank? }
    end
  end
  
  module CustomerInstanceMethods
    
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

    #TODO: Refactor
    def self.search(search)
      search_condition = "%" + search + "%"
      found_customers = find(:all, :conditions => ['LOWER(company) LIKE ? OR LOWER(phone) LIKE ?', search_condition, search_condition])

      # sort mechanism: sorts results, ones that start with the search string are presented first,
      # and results where the search string is somewhere in the result are presented afterwards.
      start_with_query = Array.new
      found_customers.each do |found|
        start_with_query.push(found) if found.company.downcase.start_with?(search.downcase)
      end
      found_customers.sort!
      start_with_query.sort!
      start_with_query | found_customers
    end
  end
  
end