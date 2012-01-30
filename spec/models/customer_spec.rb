# == Schema Information
#
# Table name: customers
#
#  id           :integer(4)      not null, primary key
#  company      :string(255)
#  phone        :string(255)
#  mobile       :string(255)
#  fax          :string(255)
#  email        :string(255)
#  language     :string(255)
#  homepage     :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  new_customer :boolean(1)      default(TRUE)
#  rating       :integer(4)
#

# factory :customer do
#   company     "Foo_Bar Inc"
#   phone       "031 123 12 34"
#   mobile      "079 123 12 34"
#   fax         "031 123 12 34"
#   email       "foo@bar.com"
#   language    "English"
#   homepage    "http://www.foobar.com"
# end

require 'spec_helper'

describe Customer do
  
  describe "validations" do
    
    describe "company validation" do
      
      it "should be present" do
        @customer = Factory.build(:customer)
        @customer.should be_valid
        @customer2 = Factory.build(:customer)
        @customer2.company = ""
        @customer2.should_not be_valid
      end
      
      it "should be unique" do
        @customer = Factory.create(:customer)
        @customer2 = Factory.build(:customer)
        @customer2.company == @customer.company
        @customer2.should_not be_valid
      end
      
      it "should be case sensitive" do
        @customer = Factory.create(:customer)
        @customer2 = Factory.build(:customer, :company => "foo_bar inc")
        @customer2.should be_valid
      end
      
    end
    
    describe "phone validation" do
      
      it "should be present" do
        @customer = Factory.build(:customer)
        @customer.should be_valid
        
        @customer = Factory.build(:customer, :phone => nil)
        @customer.should_not be_valid
        
        @customer = Factory.build(:customer, :phone => "")
        @customer.should_not be_valid
      end
      
      it "should be within 10..30 digits" do
        @customer = Factory.build(:customer)
        @customer.should be_valid
      
        @customer = Factory.build(:customer, :phone => "1"*9 )
        @customer.should_not be_valid
        

        @customer = Factory.build(:customer, :phone => "1"*15 )
        @customer.should be_valid
        
        @customer = Factory.build(:customer, :phone => "1"*31 )
        @customer.should_not be_valid
      end

    end
    
    describe "mobile validation" do
      
      it "does not need to be present" do
        @customer = Factory.build(:customer)
        @customer.should be_valid
        
        @customer = Factory.build(:customer, :mobile => nil)
        @customer.should be_valid
      end
      
      it "should be within 10..30 digits" do
        @customer = Factory.build(:customer)
        @customer.should be_valid
        
        @customer = Factory.build(:customer, :mobile => "1"*9 )
        @customer.should_not be_valid
        

        @customer = Factory.build(:customer, :mobile => "1"*15 )
        @customer.should be_valid
        
        @customer = Factory.build(:customer, :mobile => "1"*31 )
        @customer.should_not be_valid
      end
      
    end
    
    describe "fax validation" do
      
      it "does not need to be present" do
        @customer = Factory.build(:customer)
        @customer.should be_valid
        
        @customer = Factory.build(:customer, :fax => nil)
        @customer.should be_valid
      end
      
      it "should be within 10..30 digits" do
        @customer = Factory.build(:customer)
        @customer.should be_valid
        
        @customer = Factory.build(:customer, :fax => "1"*9 )
        @customer.should_not be_valid
        

        @customer = Factory.build(:customer, :fax => "1"*15 )
        @customer.should be_valid
        
        @customer = Factory.build(:customer, :fax => "1"*31 )
        @customer.should_not be_valid
      end
      
    end
    
    describe "email validation" do
      
      it "should not need to be present" do
        @customer = Factory.build(:customer)
        @customer.should be_valid
        
        @customer = Factory.build(:customer, :email => nil)
        @customer.should be_valid
      end
      
      it "should accept right email formats" do
        @customer = Factory.build(:customer, :email => "34234234@123123.com")
        @customer.should be_valid

        @customer = Factory.build(:customer, :email => "sam_fisher34@superISP.com.edu")
        @customer.should be_valid
      end
      
      it "should not accept wrong email formats" do
        @customer2 = Factory.build(:customer, :email => "www.falseInput.com")
        @customer2.should_not be_valid
        
        @customer2 = Factory.build(:customer, :email => "test_test.asdasd.com")
        @customer2.should_not be_valid
      end
      
    end
    
    describe "homepage validation" do
      
      it "should not need to be present" do
        @customer = Factory.build(:customer)
        @customer.should be_valid
        
        @customer = Factory.build(:customer, :homepage => nil)
        @customer.should be_valid
      end
      
      it "should accept right url formats" do
        @customer = Factory.build(:customer, :homepage => "http://www.testsarecool.com.not")
        @customer.should be_valid
        
        @customer = Factory.build(:customer, :homepage => "http://ftp.mib.edu.com")
        @customer.should be_valid
        
        @customer = Factory.build(:customer, :homepage => "https://www.testing.com")
        @customer.should be_valid
        
      end
      
      it "should not accept wrong url formats" do
        @customer = Factory.build(:customer, :homepage => "http:/www.google.com")
        @customer.should_not be_valid
      end
      
    end
    
  end
  
  describe "attributes" do
    
    before(:each) do
      @customer = Factory(:customer)
    end
  
    describe "address attributes" do
      
      it "should have a contact_address attribe" do
        @customer.should respond_to(:contact_address)
      end
      
      it "should have a invoice_address attribe" do
        @customer.should respond_to(:invoice_address)
      end
      
      it "should have a delivery_address attribe" do
        @customer.should respond_to(:delivery_address)
      end
      
    end
    
  end
  
  describe "search function" do
    
    before(:each) do
      @customer = Factory(:customer)
    end
    
    it "should exist as class method" do
      @customer.class.should respond_to(:search)
    end
    
  end
  
end
