class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def update
    book = Book.find(params[:id])
    raise Book.all.inspect
    book.update(book_params)
    shelf = Shelf.find(params[:shelf][:id])

    if book.status == "Finished" && shelf.name != "Finished Reading"
      shelf = Shelf.find_by(name: "Finished Reading")
    end
    book.current_shelf.update(shelf_id: shelf.id) #unless shelf.books.include?(book)  
    book.current_shelf.delete if book.status == "Dropped"

    redirect_to user_shelves_path(current_user)
  end 

  private
    def book_params
      params.require(:book).permit(:current_page, :status)
    end 
end
