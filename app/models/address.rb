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
#  parent_id    :integer(4)
#  parent_type  :string(255)
#  country      :string(255)
#  type         :string(255)
#

class Address < ActiveRecord::Base
  
  belongs_to :parent, :polymorphic => true
  
  validates :line_1,   :presence => true
  validates :zip_code, :presence => true
  validates :city,     :presence => true
  
  def name
    self.parent.to_s
  end
  
  def location_lines
    #move back to old behaviour
    return lines
    
    return lines unless includes_name?
    l = lines
    l.shift
    l
  end

  def lines
    lines = [self.line_1]
    lines << self.line_2 unless self.line_2.blank?
    lines << self.line_3 unless self.line_3.blank?
    lines
  end
  
  def location_s(delimiter = "\n")
    self.location_lines.join(delimiter) + "#{delimiter}#{zip_code} #{city}" # + delimiter + self.country.to_s
  end
  
  def google_maps_url
    street = self.lines.last
    street.gsub(" ", "+")

    "http://maps.google.com/?q=#{street}%2C+#{self.zip_code}+#{self.city}+#{self.country}"
  end
  
end

