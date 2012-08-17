# == Schema Information
#
# Table name: user_roles
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe UserRole do
  
  before(:each) do
    @user_role = FactoryGirl.create(:sudo)
  end

  it "should have a name attribute" do
    @user_role.should respond_to(:name)
  end
  
end
