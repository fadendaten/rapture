class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :company
      t.string :phone
      t.string :mobile
      t.string :fax
      t.string :email
      t.string :language
      t.string :homepage

      t.timestamps
    end
  end
end
