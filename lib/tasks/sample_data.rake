require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(:username => "felix",
                 :email => "felix@uhu.com",
                 :password => "test123",
                 :first_name => "Felix",
                 :last_name => "Uhu")
    500.times do
      company = Faker::Name.name
      phone = "1234567890"
      email = Faker::Internet.email
      Customer.create!(:company => company, :phone => phone, :email => email)
    end
 
  end
end