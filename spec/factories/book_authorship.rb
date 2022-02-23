FactoryBot.define do
  factory :book_authorship do
    trait :book_id
    trait :author_id
  end
end
