FactoryBot.define do
  factory :user do
    role {1}
    name {Faker::Artist.name}
    address {Faker::Address.street_address}
    email {Faker::Internet.email}
    phone_number {Faker::PhoneNumber.phone_number}
    password {"123456"}
    city {Faker::Address.city}
    password_confirmation {"123456"}
  end
end
