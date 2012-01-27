FactoryGirl.define do
  factory :customer do |customer|
    customer.company     "Foo_Bar Inc"
    customer.phone       "031 123 12 34"
    customer.mobile      "079 123 12 34"
    customer.fax         "031 123 12 34"
    customer.email       "foo@bar.com"
    customer.language    "English"
    customer.homepage    "http://www.foobar.com"
  end
end