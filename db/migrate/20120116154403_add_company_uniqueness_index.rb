class AddCompanyUniquenessIndex < ActiveRecord::Migration
  def up
    add_index :customers, :company, :unique => true
  end

  def down
    remove_index :customers, :company
  end
end
