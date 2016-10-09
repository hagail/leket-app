FactoryGirl.define do
  factory :warehouse do
    priority_id { "7800#{rand(999)}" }
    name        { Faker::Company.name }
    city        { Faker::Address.city }
    address     { Faker::Address.street_address }
  end
end
