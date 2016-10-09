FactoryGirl.define do
  factory :container_report do
    quantity 4
    container
    food_type_report
    approved_at nil

    trait :not_collected do
      quantity 0
    end

    trait :approved do
      approved_at { Time.now }
    end
  end
end
