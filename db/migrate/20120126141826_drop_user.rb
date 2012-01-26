class DropUser < ActiveRecord::Migration
  def up
    drop_table "users", :force => true do |t|
      t.string   "username"
      t.string   "email"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "encrypted_password"
      t.string   "salt"
      t.string   "first_name"
      t.string   "last_name"
    end
  end

  def down
    create_table "users", :force => true do |t|
      t.string   "username"
      t.string   "email"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "encrypted_password"
      t.string   "salt"
      t.string   "first_name"
      t.string   "last_name"
    end
  end
end
