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
    
    def act_as_csv
      include ActAsCSV
    end
  end
  
  module AddressableInstanceMethods
    def self.included(base)
      base.has_one :contact_address,  :as => :parent, :dependent => :destroy
      base.has_one :invoice_address,  :as => :parent, :dependent => :destroy
      base.has_one :delivery_address, :as => :parent, :dependent => :destroy
      
      base.accepts_nested_attributes_for :contact_address,  :reject_if => lambda { |a| a[:line_1].blank? && a[:zip_code].blank? && a[:city].blank? }
      base.accepts_nested_attributes_for :invoice_address,  :reject_if => lambda { |a| a[:line_1].blank? && a[:zip_code].blank? && a[:city].blank? }
      base.accepts_nested_attributes_for :delivery_address, :reject_if => lambda { |a| a[:line_1].blank? && a[:zip_code].blank? && a[:city].blank? }
    end
  end
  
  module CustomerInstanceMethods
    def self.included(base)
      base.extend CustomerClassMethods
      base.has_many :contact_people, :as => :parent, :dependent => :destroy
      base.accepts_nested_attributes_for :contact_people, :reject_if => lambda { |a| a[:last_name].blank? }, :allow_destroy => true
    end
    
    module CustomerClassMethods
      def new_customer_duration=(duration)
        @@new_customer_duration = duration
      end

      def update_new_customer_flag
        Customer.all.each do |c|
          c.new_customer = false if c.created_at + @@new_customer_duration < Time.now
          c.save!
        end
      end
    end
    
    def to_s
      company
    end
    
    def new?
      self.new_customer
    end 

    def format_homepage_url
      unless homepage.blank? || homepage.starts_with?("http://", "https://")
        self.homepage = "http://#{homepage}"
      else
        self.homepage = homepage
      end
    end
  end
  
  module ActAsCSV
    def self.included(base)
      address_lines = {:line_1 => "",
                      :line_2 => "",
                      :line_3 => "",
                      :zip_code => "",
                      :city => "",
                      :country_code => ""}
      base.comma do
        company 'Firmenname'
        email
        phone
        mobile
        fax
        contact_address address_lines.merge(:line_1 => "Kontaktadresse")
        delivery_address address_lines.merge(:line_1 => "Lieferadresse")
        invoice_address address_lines.merge(:line_1 => "Rechnungsadresse")
      end
    end
  end
  
end