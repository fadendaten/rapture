class AddParentIdToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :parent_id, :integer
  end
end
