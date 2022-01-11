module BookHelper
  def has_author? author
    !author.blank?
  end
end
