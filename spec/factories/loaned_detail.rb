FactoryBot.define do
  factory :loaned_detail do
    trait :loaned_book_id
    trait :book_id
    trait :quantity
    status {LoanedDetail.statuses[:pending]}
  end
end
