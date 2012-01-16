class Customer < ActiveRecord::Base
  attr_accessible :company, :phone, :mobile, :fax, :email, :language, :homepage
end
