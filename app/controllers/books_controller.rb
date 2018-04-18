class BooksController < ApplicationController
  def index
    @books = Book.take(10)
  end

end
