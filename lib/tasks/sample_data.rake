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
                          :first_name => "Alfred",
                          :last_name  => "Moser")
      sudo.user_roles << sudo_role
      
      admin = User.create!(:username   => "admin",
                           :email      => "admin@admin.com",
                           :password   => "test123", 
                           :first_name => "Benjamin",
                           :last_name  => "Kaser")
      admin.user_roles << admin_role
      
      base = User.create!(:username   => "user",
                          :email      => "dani_gerber@base.com",
                          :password   => "test123",
                          :first_name => "Dani",
                          :last_name  => "Gerber")
      base.user_roles << base_role
      
      # Create customers
      company = "pit Shoes"
      phone = "056 401 22 92"
      email = "raphael@pit-shoes.com"
      contact_address = ContactAddress.new(:line_1 => "Fashion Order Mall",
                                           :line_2 => "Showroom 10-37/38"
                                           :zip_code => 8957, 
                                           :city => "Spreitenbach")
      
      Customer.create!(:company => company, :phone => phone, :email => email, :contact_address => contact_address)
      
      500.times do
        company = Faker::Name.name
        phone   = Faker::PhoneNumber.phone_number
        email   = Faker::Internet.email
        
        # Create contact address for customer
        contact_address = ContactAddress.new(:line_1 => Faker::Address.street_address, 
                                             :zip_code => Faker::Address.zip_code, 
                                             :city => Faker::Address.city)
                                             
        Customer.create!(:company => company, :phone => phone, :email => email, :contact_address => contact_address)
      end
      Rake::Task['db:set_new_time'].invoke
    end
    
    
    task :set_new_time => :environment do
      Customer.all.each do |c|
        c.created_at = Time.now - 2.years if c.id < 200
        c.save!
      end
      
      Customer.new_customer_duration = 5.months
      Customer.update_new_customer_flag
    end
  end
end