FactoryGirl.define do
  factory :comment do
    body "MyText"
    post_id 1
    user nil
  end
end
