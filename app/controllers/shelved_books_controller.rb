class ShelvedBooksController < ApplicationController
  def create   
    ShelvedBook.create(shelved_book_params)
    redirect_to user_shelves_path(current_user)
  end

  private
    def shelved_book_params
      params.require(:shelved_book).permit(:shelf_id, :book_id)
    end 

end
