class ShelvedBooksController < ApplicationController
  def create   
    book = Book.find(params[:shelved_book][:book_id])
    if current_user.books.include?(book)
      redirect_to books_path, notice: "You already have this book."
    else
      ShelvedBook.create(shelved_book_params) 
      redirect_to user_shelves_path(current_user)
    end
  end

  def update
    shelved_book = ShelvedBook.find(params[:id])
    shelved_book.update(shelved_book_params)
 
    if shelved_book.status == "Finished" 
      shelved_book.shelf = Shelf.find_by(name: "Finished Reading")
      shelved_book.current_page = shelved_book.book.page_count
    elsif shelved_book.status != "Finished" && shelved_book.shelf.name == "Finished Reading"
      shelved_book.shelf = Shelf.find_by(name: "Reading")
      shelved_book.current_page = shelved_book.book.page_count - 1
    elsif shelved_book.current_page == shelved_book.book.page_count
      shelved_book.shelf = Shelf.find_by(name: "Finished Reading")
      shelved_book.status = "Finished" 
    elsif shelved_book.status == "Plan to Read" 
      shelved_book.current_page = 0
    end

    shelved_book.book.current_shelf = shelved_book
    shelved_book.book.current_shelf.delete if shelved_book.status == "Dropped"

    redirect_to user_shelves_path(current_user)
  end

  private
    def shelved_book_params
      params.require(:shelved_book).permit(:shelf_id, :book_id, :current_page, :status)
    end 

end
