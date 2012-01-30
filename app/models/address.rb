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
#  country      :string(255)
#

class Address < ActiveRecord::Base
  
  belongs_to :parent, :polymorphic => true
  
  validates :line_1,       :presence => true
  validates :zip_code,     :presence => true
  validates :city,         :presence => true

  def lines
    lines = [self.line_1]
    lines << self.line_2 unless self.line_2.blank?
    lines << self.line_3 unless self.line_3.blank?
    lines
  end
  
end

