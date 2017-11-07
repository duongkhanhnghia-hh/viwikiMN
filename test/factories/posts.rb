FactoryGirl.define do
  factory :post do
    title "MyString"
    body "MyText"
    category_id 1
    user nil
  end
end
