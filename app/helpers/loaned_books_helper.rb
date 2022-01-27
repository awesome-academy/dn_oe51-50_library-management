module LoanedBooksHelper
  def arr_status_loaned
    LoanedBook.statuses
  end
end
