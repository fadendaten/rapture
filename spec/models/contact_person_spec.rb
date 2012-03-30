# == Schema Information
#
# Table name: contact_people
#
#  id          :integer(4)      not null, primary key
#  parent_id   :integer(4)
#  parent_type :string(255)
#  first_name  :string(255)
#  last_name   :string(255)
#  phone       :string(255)
#  mail        :string(255)
#  fax         :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe ContactPerson do
  pending "add some examples to (or delete) #{__FILE__}"
end
