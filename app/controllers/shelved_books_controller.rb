class ShelvedBooksController < ApplicationController
  def create   
    ShelvedBook.create(shelved_book_params)
    redirect_to user_shelves_path(current_user)
  end

  def update
    shelved_book = ShelvedBook.find(params[:id])
    shelved_book.update(shelved_book_params)
 
    if shelved_book.status == "Finished" 
      shelved_book.shelf = Shelf.find_by(name: "Finished Reading")
    elsif shelved_book.status != "Finished" && shelved_book.shelf.name == "Finished Reading"
      shelved_book.shelf = Shelf.find_by(name: "Reading")
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
