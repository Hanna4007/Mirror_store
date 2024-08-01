FactoryBot.define do
  factory :order do
    association :user, factory: :user
    status {"in progress"}
    total_price {Faker::Commerce.price}

    
  end
end
  