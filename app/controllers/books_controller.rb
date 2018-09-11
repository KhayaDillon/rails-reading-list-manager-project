class BooksController < ApplicationController
  def index
    @books = Book.take(10)
  end

  def recent_book
    @book = current_user.recent_book
  end

end
