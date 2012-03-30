class CreateContactPeople < ActiveRecord::Migration
  def change
    create_table :contact_people do |t|
        t.integer :parent_id
        t.string :parent_type
        t.string :first_name
        t.string :last_name
        t.string :phone
        t.string :mail
        t.string :fax
      t.timestamps
    end
  end
end
