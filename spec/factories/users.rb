FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    name {Faker::Internet.username}
    password {"12345678"}
    password_confirmation {"12345678"}
    admin {false}
    phone_number { "+#{Faker::Number.number(digits: 12)}" }
       
  end
end
