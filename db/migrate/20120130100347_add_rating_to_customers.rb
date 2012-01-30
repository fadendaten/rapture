class AddRatingToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :rating, :integer
  end
end
