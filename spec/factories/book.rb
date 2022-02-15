FactoryBot.define do
  factory :book do
    category_id {create(:category).id}
    book_title {Faker::Book.title}
    isbn {Faker::Number.between(from: 1000, to: 2000)}
    year_published {Faker::Date.between(from: "1999-01-23", to: "1999-12-25")}
    description {Faker::Books::Dune.character}
    quantity {Faker::Number.between(from: 20, to: 30)}
    publishing_house {Faker::Book.publisher}
  end
end
