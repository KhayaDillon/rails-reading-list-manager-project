class ShelvedBooksController < ApplicationController
  def create   
    book = Book.find(params[:shelved_book][:book_id])
    if current_user.books.include?(book)
      redirect_to books_path, notice: "You already have this book."
    else
      shelved_book = ShelvedBook.create(shelved_book_params) 

      if shelved_book.shelf.name == "Finished Reading"
        shelved_book.update(status: "Finished", current_page: shelved_book.book.page_count)
      else
        shelved_book.update(status: "Plan to Read")
      end

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
      #If current page has not been appropriately lowered, don't change status
      if shelved_book.current_page == shelved_book.book.page_count
        shelved_book.status = "Finished" 
        flash[:alert] = "Your book's status is no longer finished? Then your current page can't be the last page. Please update your current page accordingly."
      #Move to Reading shelf if shelf is not given, but status and current page has been adjusted appropriately
      else 
        shelved_book.shelf = Shelf.find_by(name: "Reading")
      end
    #If the status has been left to Finished but the shelf has been changed to Reading
    elsif shelved_book.status == "Finished" && shelved_book.status == old_status && shelved_book.shelf.name == "Reading"
      shelved_book.shelf = Shelf.find_by(name: old_shelf)
      flash[:alert] = "Books you have finished can't be put on your Reading Shelf. Please update your status and current page."
    #If user changes the shelf to Finished
    elsif shelved_book.shelf.name == "Finished Reading" && shelved_book.shelf.name != old_shelf
      #If user has not altered book status 
      if shelved_book.status == old_status 
        shelved_book.status = "Finished"  
      #If the user had also altered the status, and it's not Finished
      elsif shelved_book.status != "Finished"
        flash[:alert] = "You can't put a book that is not finished on your Finished Reading Shelf. Please change the book's status."
        shelved_book.shelf = Shelf.find_by(name: old_shelf)
      end

    #elsif shelved_book.current_page == shelved_book.book.page_count && #shelved_book.status != "Finished" && shelved_book.status == old_status
    #  shelved_book.status = "Finished" 
    end

    case shelved_book.status
    when "Finished" 
      if shelved_book.current_page != shelved_book.book.page_count
        shelved_book.current_page = shelved_book.book.page_count
        flash[:notice] = "Books you have finished can't have pages left to read. Current page has been set to last page."
      end
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
        shelved_book.current_page = 0
        flash[:notice] = "Books you plan to read can't have a current page. Current page has been changed to zero."
      end
    when "Dropped" 
      book_title = shelved_book.book.title
      flash[:notice] = "#{book_title} has been removed from your shelves."
      shelved_book.delete 
    end

    if shelved_book
      shelved_book.save
    end 

    redirect_to user_shelves_path(current_user)
  end

  private
    def shelved_book_params
      params.require(:shelved_book).permit(:shelf_id, :book_id, :current_page, :status)
    end 

end
