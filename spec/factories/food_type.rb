FactoryGirl.define do
  factory :food_type do
    priority_id { "NP00#{rand(99)}" }
    name      "Bread"

    transient do
      container_count 3
    end

    after(:create) do |food_type, evaluator|
      create_list(:container, evaluator.container_count, food_type: food_type)
    end
  end
end
