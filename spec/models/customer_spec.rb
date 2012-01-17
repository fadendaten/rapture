require 'spec_helper'

describe Customer do
  
  before(:each) do
    @attr = {
      :company =>   "Foo_Bar Inc.",
      :phone =>     "123 123 12 34",
      :mobile =>    "123 123 12 34",
      :fax =>       "123 123 12 34",
      :email =>     "foo@bar.com",
      :language =>  "English",
      :homepage =>  "http://www.example.com"
    }
    @attr2 = {
      :company =>   "Foo_Bar Inc.",
      :phone =>     "444 444 44 55",
      :mobile =>    "444 444 44 55",
      :fax =>       "444 444 44 55",
      :email =>     "dani@dani.com",
      :language =>  "Italiano",
      :homepage =>  "http://www.foobar.com"
    }
  end
  
  describe "validations" do
    
    describe "company validation" do
      
      it "should be present" do
        @customer = Customer.new(@attr)
        @customer.should be_valid
        @attr[:company] = ""
        @customer2 = Customer.new(@attr)
        @customer2.should_not be_valid
      end
      
      it "should be unique" do
        @customer = Customer.create!(@attr)
        @customer2 = Customer.new(@attr2)
        @customer2.should_not be_valid
      end
      
      it "should be case sensitive" do
        @customer = Customer.create!(@attr)
        @attr2[:company] = "foo_bar Inc."
        @customer2 = Customer.new(@attr2)
        @customer2.should be_valid
      end
      
    end
    
    describe "phone validation" do
      
      it "should be present" do
        @customer = Customer.new(@attr)
        @customer.should be_valid
        
        @attr[:phone] = nil
        @customer2 = Customer.new(@attr)
        @customer2.should_not be_valid
        
        @attr[:phone] = ""
        @customer2 = Customer.new(@attr)
        @customer2.should_not be_valid
      end
      
      it "should be within 10..15 digits" do
        @customer = Customer.new(@attr)
        @customer.should be_valid
        
        @attr[:phone] = "123 456"
        @customer2 = Customer.new(@attr)
        @customer2.should_not be_valid
        
        @attr[:phone] = "123 456 78 90"
        @customer = Customer.new(@attr)
        @customer.should be_valid
        
        @attr[:phone] = "123 456 78 90 11 12"
        @customer2 = Customer.new(@attr)
        @customer2.should_not be_valid
      end

    end
    
    describe "mobile validation" do
      
      it "does not need to be present" do
        @customer = Customer.new(@attr)
        @customer.should be_valid
        
        @attr[:mobile] = nil
        @customer = Customer.new(@attr)
        @customer.should be_valid
      end
      
      it "should be within 10..15 digits" do
        @customer = Customer.new(@attr)
        @customer.should be_valid
        
        @attr[:mobile] = "123 456"
        @customer2 = Customer.new(@attr)
        @customer2.should_not be_valid
        
        @attr[:mobile] = "123 456 78 90"
        @customer = Customer.new(@attr)
        @customer.should be_valid
        
        @attr[:mobile] = "123 456 78 90 11 12"
        @customer2 = Customer.new(@attr)
        @customer2.should_not be_valid
      end
      
    end
    
    describe "fax validation" do
      
      it "does not need to be present" do
        @customer = Customer.new(@attr)
        @customer.should be_valid
        
        @attr[:fax] = nil
        @customer = Customer.new(@attr)
        @customer.should be_valid
      end
      
      it "should be within 10..15 digits" do
        @customer = Customer.new(@attr)
        @customer.should be_valid
        
        @attr[:fax] = "123 456"
        @customer2 = Customer.new(@attr)
        @customer2.should_not be_valid
        
        @attr[:fax] = "123 456 78 90"
        @customer = Customer.new(@attr)
        @customer.should be_valid
        
        @attr[:fax] = "123 456 78 90 11 12"
        @customer2 = Customer.new(@attr)
        @customer2.should_not be_valid
      end
      
    end
    
    describe "email validation" do
      
      it "should not need to be present" do
        @customer = Customer.new(@attr)
        @customer.should be_valid
        
        @attr[:email] = nil
        @customer = Customer.new(@attr)
        @customer.should be_valid
      end
      
      it "should accept right email formats" do
        @attr[:email] = "34234234@123123.com"
        @customer = Customer.new(@attr)
        @customer.should be_valid
        
        @attr[:email] = "sam_fisher34@superISP.com.edu"
        @customer = Customer.new(@attr)
        @customer.should be_valid
      end
      
      it "should not accept wrong email formats" do
        @attr[:email] = "www.falseInput.com"
        @customer2 = Customer.new(@attr)
        @customer2.should_not be_valid
        
        @attr[:email] = "test_test.asdasd.com"
        @customer2 = Customer.new(@attr)
        @customer2.should_not be_valid
      end
      
    end
    
    describe "homepage validation" do
      
      it "should not need to be present" do
        @customer = Customer.new(@attr)
        @customer.should be_valid
        
        @attr[:homepage] = nil
        @customer = Customer.new(@attr)
        @customer.should be_valid
      end
      
      it "should accept right url formats" do
        @attr[:homepage] = "http://www.testsarecool.com.not"
        @customer = Customer.new(@attr)
        @customer.should be_valid
        
        @attr[:homepage] = "http://ftp.mib.edu.com"
        @customer = Customer.new(@attr)
        @customer.should be_valid
        
        @attr[:homepage] = "https://www.testing.com"
        @customer = Customer.new(@attr)
        @customer.should be_valid
        
      end
      
      it "should not accept wrong url formats" do
        @attr[:homepage] = "www.nohttp.com"
        @customer = Customer.new(@attr)
        @customer.should_not be_valid
        
        @attr[:homepage] = "http:/www.google.com"
        @customer = Customer.new(@attr)
        @customer.should_not be_valid
      end
      
    end
    
  end
  
  describe "to_s" do
    
    it "should return company" do
      @attr[:company].should == "Foo_Bar Inc."
      @customer = Customer.new(@attr)
      @customer.to_s.should == "Foo_Bar Inc."
    end
    
  end
  
end
