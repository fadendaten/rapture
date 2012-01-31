require 'faker'

namespace :db do
  if Rails.env.development?
    desc "Fill database with sample data"
    task :seed => :environment do
      Rake::Task['db:reset'].invoke
      
      # Create roles
      sudo_role  = UserRole.create!(:name => "sudo")
      admin_role = UserRole.create!(:name => "admin")
      base_role  = UserRole.create!(:name => "base")
      
      # Create users
      sudo = User.create!(:username   => "sudo", 
                          :email      => "sudo@sudo.com",
                          :password   => "test123",
                          :first_name => "Simon",
                          :last_name  => "Fuetzgue")
      sudo.user_roles << sudo_role
      
      admin = User.create!(:username   => "admin",
                           :email      => "admin@admin.com",
                           :password   => "test123", 
                           :first_name => "Chrigu",
                           :last_name  => "Da Boss")
      admin.user_roles << admin_role
      
      base = User.create!(:username   => "spongebob",
                          :email      => "squarepants@bikinibottom.com",
                          :password   => "test123",
                          :first_name => "Felix",
                          :last_name  => "Uhu")
      base.user_roles << base_role
      
      # Create customers
      500.times do
        company = Faker::Name.name
        phone   = Faker::PhoneNumber.phone_number
        email   = Faker::Internet.email
        Customer.create!(:company => company, :phone => phone, :email => email)
      end
      
      Customer.all.each do |c|
        c.created_at = Time.now - 2.years if c.id < 200
        c.save
      end
      
      Customer.new_customer_duration = 5.months
      Customer.update_new_customer_flag
    end
  end
end