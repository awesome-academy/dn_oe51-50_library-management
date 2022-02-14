module LoanedBooksHelper
  def arr_status_loaned
    LoanedBook.statuses
  end

  def get_date_returned date_returned
    date_returned.present? ? I18n.l(date_returned) : I18n.t("loaned_books.loaned_book.none_return")
  end
end
