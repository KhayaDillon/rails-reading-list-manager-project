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
    old_shelf = shelved_book.shelf
    shelved_book.update(shelved_book_params)
    
    case shelved_book.status
    when "Finished" 
      shelved_book.shelf = Shelf.find_by(name: "Finished Reading")
      shelved_book.current_page = shelved_book.book.page_count
    when "On Hold" 
      if shelved_book.current_page == shelved_book.book.page_count
        shelved_book.shelf = Shelf.find_by(name: "Finished Reading")
        shelved_book.status = "Finished" 
        flash[:notice] = "You can't put on hold a book you've finished."
      elsif shelved_book.current_page == 0
        shelved_book.current_page == 1
        flash[:notice] = "You can't put on hold a book you haven't started reading."
      end
    when "Plan to Read" 
      shelved_book.current_page = 0
    when shelved_book.status == "Dropped" 
      shelved_book.book.current_shelf.delete 
    end

    if old_shelf == "Finished Reading" && shelved_book.status != "Finished" 
      shelved_book.shelf = Shelf.find_by(name: "Reading")
      shelved_book.current_page = 0
    elsif shelved_book.current_page == shelved_book.book.page_count && shelved_book.shelf.name != "Finished Reading"
      shelved_book.shelf = Shelf.find_by(name: "Finished Reading")
      shelved_book.status = "Finished" 
    end

    
    if shelved_book.book.current_shelf
      shelved_book.book.current_shelf = shelved_book
      redirect_to user_shelves_path(current_user)
    end
  end

  private
    def shelved_book_params
      params.require(:shelved_book).permit(:shelf_id, :book_id, :current_page, :status)
    end 

end
