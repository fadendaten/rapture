class CreateUserRoleAssignments < ActiveRecord::Migration
  def change
    create_table :user_role_assignments do |t|
      t.integer :user_id
      t.integer :user_role_id

      t.timestamps
    end
  end
end
