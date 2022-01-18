module CartsHelper
  def current_cart
    session[:cart] ||= Array.new
  end

  def get_all_item_in_cart
    cart_items = []
    current_cart.each do |item|
      book = Book.find_by(id: item["book_id"])
      if book
        cart_items << {
          book: book,
          quantity: item["quantity"]
        }
      else
        current_cart.delete(item)
      end
    end
    cart_items
  end

  def find_book_in_cart book
    current_cart.find{|item| item["book_id"] == book.id}
  end

  def total_loan_books
    items = get_all_item_in_cart
    items.reduce(0){|sum, item| sum + item[:quantity].to_i}
  end
end
