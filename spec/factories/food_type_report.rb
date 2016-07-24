FactoryGirl.define do
  factory :food_type_report do
    food_type

    transient do
      container_reports_count 1
    end

    after(:create) do |food_type_report, evaluator|
      create_list(:container_report, evaluator.container_reports_count, food_type_report: food_type_report)
    end
  end
end
