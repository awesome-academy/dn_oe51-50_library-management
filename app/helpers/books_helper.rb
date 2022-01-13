module BooksHelper
  def get_books_sort_by_title
    Book.books_sort_asc_by_title
  end

  def render_time_now
    Time.now.strftime(Settings.format_date.y_m_d)
  end

  def render_time_date_due
    (Time.now + Settings.df_date_due.days).strftime(Settings.format_date.y_m_d)
  end
end
