FactoryBot.define do
  factory :loaned_book do
    trait :user_id
    date_loaned {Time.now}
    date_due {Time.now + Settings.df_date_due.days}
    date_returned {nil}
    overdue_fee {nil}
    status {LoanedBook.statuses[:pending]}
    quantity {1}
  end
end
