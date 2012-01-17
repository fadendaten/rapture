class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :line_1
      t.string :line_2
      t.string :line_3
      t.string :zip_code
      t.string :city
      t.string :country_code

      t.timestamps
    end
  end
end
