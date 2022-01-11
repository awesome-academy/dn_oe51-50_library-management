module CartsHelper
  def current_cart
    session[:cart] ||= Hash.new
  end

  def get_all_item_in_cart
    cart_items = {}
    current_cart.each do |book_id, quantity|
      book = Book.find_by(id: book_id)
      if book
        cart_items.merge! book => quantity
      else
        current_cart.delete book_id
      end
    end
    cart_items
  end

  def find_book_in_cart book
    current_cart.find{|book_id, quantity| book_id == book.id.to_s}
  end

  def total_loan_books
    items = get_all_item_in_cart
    items.reduce(0){|sum, item| sum + item.second.to_i}
  end
end
