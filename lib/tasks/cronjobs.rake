namespace :db do

  desc  "Update customers 'new_customer' attribute"
  task :update_new_customer => :environment do
    Customer.new_customer_duration = Customer.new_customer_duration
    Customer.update_new_customer_flag
  end
  
  
end