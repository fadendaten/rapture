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

  end
  
end