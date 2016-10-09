FactoryGirl.define do
  factory :pickup do
    priority_id { rand(10000) + 10000 }
    date { Date.today }

    approved_at nil
    sent_at nil

    user
    supplier

    trait :single_supplier do
      supplier { create(:supplier, :top_supplier, suppliers_count: 0) }
    end
  end
end
