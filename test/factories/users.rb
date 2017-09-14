FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password "$2a$11$VmsnPhZSsUehLgfEnAoM1eomW.My7p9eZunbF84cb2BfGniwbNy1W" #123456

  end
end
