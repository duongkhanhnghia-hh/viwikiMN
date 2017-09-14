FactoryGirl.define do
  factory :article do
    name Faker::Book.title
    association :category
  end
end
