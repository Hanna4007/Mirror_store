FactoryBot.define do
  factory :mirror do
    name {Faker::Commerce.product_name}
    height {50}
    width {50}
    glass_thickness {4}
    light { "neutral" }
    installation { "wall" }
    lamp { "built-in" }
    price_square {Faker::Commerce.price}
    heater {Faker::Boolean.boolean}
    description { "This is a test description." }
  end
end
