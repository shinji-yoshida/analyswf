# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    name "MyString"
    image_type "MyString"
    resource nil
  end
end