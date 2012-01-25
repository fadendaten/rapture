# == Schema Information
#
# Table name: addresses
#
#  id           :integer(4)      not null, primary key
#  line_1       :string(255)
#  line_2       :string(255)
#  line_3       :string(255)
#  zip_code     :string(255)
#  city         :string(255)
#  country_code :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  type         :string(255)
#  parent_id    :integer(4)
#  parent_type  :string(255)
#

require 'spec_helper'

describe Address do
  
  before(:each) do
    @customer = Factory(:customer)
    @attr = Factory(:address).attributes
  end
  
  it "should create new address instances with valid attributes" do
    @customer.create_contact_address!(@attr)
    @customer.create_invoice_address!(@attr)
    @customer.create_delivery_address!(@attr)
  end
  
  describe "with parent associations" do
    
    before(:each) do
      @address = @customer.create_contact_address!(@attr)
    end
    
    it "should have a parent attribute" do
      @address.should respond_to(:parent)
    end
    
    it "should have the right associated parent" do
      @address.parent_id.should == @customer.id
    end
    
  end
  
  describe "with specific associations with customer" do
    
    before(:each) do
      @address = @customer.create_contact_address!(@attr)
    end
    
    it "should have a customer as parent type" do
      @address.parent_type.should == "Customer"
    end
    
  end
  
  describe "validations" do
    
    it "should have a line_1" do
      Address.new(@attr.merge(:line_1 => "")).should_not be_valid
    end
    
    it "should have a zip_code" do
      Address.new(@attr.merge(:zip_code => "")).should_not be_valid
    end
    
    it "should have a city" do
      Address.new(@attr.merge(:city => "")).should_not be_valid
    end
    
  end
  
  
  
end
