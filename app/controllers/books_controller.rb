class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    shelf = Shelf.find(params[:shelf][:id])
    book.shelves << shelf unless shelf.books.include?(shelf)
    redirect_to shelves_path
  end 

  private
    def book_params
      params.require(:book).permit(:current_page, :status)
    end 
end
