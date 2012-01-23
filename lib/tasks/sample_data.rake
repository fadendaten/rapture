require 'faker'

namespace :db do
  if Rails.env.development?
    desc "Fill database with sample data"
    task :seed => :environment do
      Rake::Task['db:reset'].invoke
      admin_role = UserRole.create!(:name => 'admin')
      admin = User.create!(:username => "admin",
                   :email => "felix@uhu.com",
                   :password => "test123",
                   :first_name => "Chrigu",
                   :last_name => "DaBoss")
      admin.user_roles.push(admin_role)
      User.create!(:username => "felix",
                   :email => "felix@uhu.com",
                   :password => "test123",
                   :first_name => "Felix",
                   :last_name => "Uhu")
      500.times do
        company = Faker::Name.name
        phone = Faker::PhoneNumber.phone_number
        email = Faker::Internet.email
        Customer.create!(:company => company, :phone => phone, :email => email)
      end
    end
  end
end