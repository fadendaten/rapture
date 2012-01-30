class AddNewCustomerFlagToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :new_customer, :boolean, :default => true 
  end
end
