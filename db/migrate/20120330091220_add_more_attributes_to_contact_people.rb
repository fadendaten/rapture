class AddMoreAttributesToContactPeople < ActiveRecord::Migration
  def change
    change_table :contact_people do |t|
      t.string :description, :language, :mobile
      t.boolean :primary
      t.rename :mail, :email
    end
  end
end
