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
    old_shelf = shelved_book.shelf.name
    old_status = shelved_book.status
    shelved_book.update(shelved_book_params)
    
    #When book is on Finished shelf and only the status gets changed
    if shelved_book.shelf.name == "Finished Reading" && shelved_book.shelf.name == old_shelf && shelved_book.status != "Finished" && shelved_book.status != "Dropped" 
      if shelved_book.current_page == shelved_book.book.page_count
        shelved_book.status = "Finished" 
        flash[:notice] = "Your book's status is no longer finished? Then your current page can't be the last page. Please update your current page accordingly."
      else 
        shelved_book.shelf = Shelf.find_by(name: "Reading")
      end
    elsif shelved_book.status == "Finished" && shelved_book.status == old_status && shelved_book.shelf.name == "Reading"
      shelved_book.shelf = Shelf.find_by(name: old_shelf)
      flash[:notice] = "Books you have finished can't be put on your Reading Shelf. Please update your status and current page."
    elsif shelved_book.status = "Plan to Read" && shelved_book.shelf.name == "Finished Reading" 
      flash[:notice] = "You can't put a book you plan to read in your Finished Reading Shelf."
    elsif shelved_book.current_page == shelved_book.book.page_count && shelved_book.status != "Finished" && shelved_book.status == old_status
      shelved_book.status = "Finished" 
    elsif shelved_book.shelf.name == "Finished Reading" && shelved_book.shelf.name != old_shelf
      shelved_book.status = "Finished"
    end

    case shelved_book.status
    when "Finished" 
      shelved_book.current_page = shelved_book.book.page_count
      shelved_book.shelf = Shelf.find_by(name: "Finished Reading") if shelved_book.shelf.name == "Reading"
    when "On Hold", "Currently Reading"
      if shelved_book.current_page == shelved_book.book.page_count
        shelved_book.shelf = Shelf.find_by(name: "Finished Reading")
        shelved_book.status = "Finished" 
        flash[:notice] = "You can't put on hold or be currently reading a book you've finished. Please update your current page."
      elsif shelved_book.current_page == 0
        shelved_book.status = old_status
        flash[:notice] = "You can't put on hold or be currently reading a book you haven't started. Please update your current page."
      end
    when "Plan to Read"
      if shelved_book.current_page != 0
        flash[:notice] = "Books you plan to read can't have a current page higher than zero."
      end
      shelved_book.current_page = 0
    when "Dropped" 
      shelved_book.delete 
    end

    shelved_book.save if shelved_book
    redirect_to user_shelves_path(current_user)
  end

  private
    def shelved_book_params
      params.require(:shelved_book).permit(:shelf_id, :book_id, :current_page, :status)
    end 

end
