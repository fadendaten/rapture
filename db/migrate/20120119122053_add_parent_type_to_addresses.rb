class AddParentTypeToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :parent_type, :string
  end
end
