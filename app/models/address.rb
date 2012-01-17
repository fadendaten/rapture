class Address < ActiveRecord::Base
  
  attr_accessible :line_1, :line_2, :line_3, :zip_code, :city, :country_id
  
  validates :line_1, :presence => true
  validates :zip_code, :presence => true
  validates :city, :presence => true
  validates :country_id, :presence => true
  
end
