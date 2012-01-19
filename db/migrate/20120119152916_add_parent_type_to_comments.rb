class AddParentTypeToComments < ActiveRecord::Migration
  def change
    add_column :comments, :parent_type, :string
  end
end
