FactoryBot.define do
  factory :delivery do
    association :order, factory: :order
    delivery_type { "Delivery to the post office" }
    post {"Nova post"}
    receiver_name {Faker::Name.name}
    receiver_surname {Faker::Name.last_name}
    receiver_phone_number { "+#{Faker::Number.number(digits: 12)}" }
    city {Faker::Address.city}
    receiver_address {Faker::Address.street_address}
    post_office_number {Faker::Number.non_zero_digit}
    region {Faker::Address.state}

  end
end
