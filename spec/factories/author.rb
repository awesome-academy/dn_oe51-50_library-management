FactoryBot.define do
  factory :author do
    author_name {Faker::Book.author}
    date_birth {Faker::Date.between(from: "1930-01-23", to: "1999-12-25")}
    date_death {Faker::Date.between(from: "2000-01-23", to: "2000-12-25")}
  end
end
