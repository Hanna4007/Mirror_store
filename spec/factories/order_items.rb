FactoryBot.define do
  factory :order_item do
    association :mirror, factory: :mirror
    association :order, factory: :order
    unit_price {Faker::Commerce.price}
    quantity {Faker::Number.number}
  end
end
