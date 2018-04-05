class ShelvesController < ApplicationController
  def index
    if user_signed_in?
      @shelves = current_user.shelves
      @shelf = Shelf.new
    else 
      redirect_to root_path, notice: "You must be signed in to view your shelves."
    end 
  end

  def create 
    Shelf.create(shelf_params)
    redirect_to user_shelves_path(current_user)
  end 

  private
    def shelf_params
      params.require(:shelf).permit(:name, :user_id)
    end
end
