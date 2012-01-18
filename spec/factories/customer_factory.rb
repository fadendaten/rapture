FactoryGirl.define do
  factory :customer do
    company     "Foo_Bar Inc"
    phone       "031 123 12 34"
    mobile      "079 123 12 34"
    fax         "031 123 12 34"
    email       "foo@bar.com"
    language    "English"
    homepage    "http://www.foobar.com"
  end
end