class ShelvedBooksController < ApplicationController
  def create   
    shelved_book = ShelvedBook.new(shelved_book_new_hash)
    if current_user.has_book?(shelved_book.title)
      redirect_to books_path, notice: "You already have this book."
    else
      BookOrganizer.take_out(shelved_book)

      redirect_to user_shelves_path(current_user)
    end
  end

  def update
    shelved_book = ShelvedBook.find(params[:id])
    old_stats = shelved_book.dup
    shelved_book.update(shelved_book_params)

    book_info = {updated: shelved_book, old: old_stats, owner: current_user}
    
    BookOrganizer.status_change_from_fin_shelf(book_info, flash)

    BookOrganizer.shelf_set_to_read_with_fin_status(book_info, flash)

    BookOrganizer.shelf_set_to_fin(book_info, flash)

    case shelved_book.status
    when "Finished" 
      if shelved_book.current_page != shelved_book.page_count
        shelved_book.current_page = shelved_book.page_count
        flash[:notice] = "Books you have finished can't have pages left to read. Current page has been set to last page."
      end
      shelved_book.set_shelf(current_user, "Finished Reading") if shelved_book.shelf_name == "Reading"
    when "On Hold", "Currently Reading"
      if shelved_book.current_page == shelved_book.page_count
        shelved_book.set_shelf(current_user, old_stats.shelf_name)
        shelved_book.status = old_stats.status 
        shelved_book.current_page = old_stats.current_page
        flash[:notice] = "You can't put on hold or be currently reading a book you've finished. Please update your current page."
      elsif shelved_book.current_page == 0
        shelved_book.status = "Plan to Read"
        flash[:notice] = "You can't put on hold or be currently reading a book you haven't started. Please update your current page. Status has been set to Plan to Read."
      end
    when "Plan to Read"
      if shelved_book.current_page != 0
        shelved_book.current_page = 0
        flash[:notice] = "Books you plan to read can't have a current page. Current page has been changed to zero."
      end
    when "Dropped" 
      book = shelved_book.book
      shelved_book.destroy
      flash[:notice] = "#{book.title} has been removed from your shelves."
      book.delete
    end
 
    if shelved_book
      shelved_book.save
    end 

    redirect_to user_shelves_path(current_user)
  end

  private
    def shelved_book_new_hash
      shelf = Shelf.find(params[:shelved_book][:shelf_id])
      book = Book.find(params[:shelved_book][:book_id])
      book_copy = book.dup
      book_copy.save
      {shelf_id: shelf.id, book_id: book_copy.id}
    end 

    def shelved_book_params
      params.require(:shelved_book).permit(:shelf_id, :book_id, :current_page, :status)
    end 
end
