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
    shelf = Shelf.create(shelf_params)
    redirect_to user_shelves_path(current_user, anchor: "#{shelf.id}")
  end 

  def edit
    @shelves = current_user.shelves
    @shelf = Shelf.find(params[:id])
    render :index
  end 

  def update
    shelf = Shelf.find(params[:id])
    shelf.update(shelf_params)
    redirect_to user_shelves_path(current_user)
  end

  def destroy
    shelf = Shelf.find(params[:id])
    name = shelf.name
    shelf.books.destroy_all
    shelf.destroy
    redirect_to user_shelves_path(current_user), notice: "#{name} Shelf has been deleted."
  end

  private
    def shelf_params
      params.require(:shelf).permit(:name, :user_id)
    end
end
