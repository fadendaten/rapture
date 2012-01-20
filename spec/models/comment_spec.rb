# == Schema Information
#
# Table name: comments
#
#  id          :integer(4)      not null, primary key
#  author      :string(255)
#  content     :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  parent_id   :integer(4)
#  parent_type :string(255)
#

require 'spec_helper'

describe Comment do
end
