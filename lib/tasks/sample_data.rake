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
                                           :line_2 => "Showroom 10-37/38",
                                           :zip_code => 8957, 
                                           :city => "Spreitenbach")
      
      Customer.create!(:company => company, :phone => phone, :email => email, :contact_address => contact_address)
      
      Customer.new_customer_duration = 5.months
      200.times do |t|
        company = Faker::Company.name
        phone   = Faker::PhoneNumber.phone_number
        email   = Faker::Internet.email
        
        # Create contact address for customer
        contact_address = ContactAddress.new(:line_1 => Faker::Address.street_address, 
                                             :zip_code => Faker::Address.zip_code, 
                                             :city => Faker::Address.city)
                                             
        Customer.create!(:company => company, :phone => phone, :email => email, :contact_address => contact_address)
        new_customer = Customer.last
        new_customer.new_customer = false if new_customer.id < 100
        new_customer.save!
      end
    end

  end
end