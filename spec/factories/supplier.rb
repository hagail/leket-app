FactoryGirl.define do
  factory :supplier do
    priority_id { "FS000#{rand(999)}" }
    name { Faker::Company.name }

    trait :sub_supplier do
      supplier
    end

    trait :top_supplier do
      transient do
        suppliers_count 3
      end

      after(:create) do |supplier, evaluator|
        create_list(:supplier, evaluator.suppliers_count, supplier: supplier)
      end
    end
  end
end
