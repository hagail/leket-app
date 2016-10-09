FactoryGirl.define do
  factory :user do
    priority_id { "VOL1000#{rand(9999)}" }
    email { Faker::Internet.email }
    name  { Faker::Name.name }
    phone { Faker::PhoneNumber.cell_phone }
  end
end
