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
#  customer_id  :integer(4)
#

class Address < ActiveRecord::Base
  
  attr_accessible :line_1, :line_2, :line_3, :zip_code, :city, :country_id, :type
  
  belongs_to :customer
  
  validates :line_1, :presence => true
  validates :zip_code, :presence => true
  validates :city, :presence => true
  validates :country_id, :presence => true
  
end

