class ShelvesController < ApplicationController
  def index
    if user_signed_in?
      @shelves = current_user.shelves
    else 
      redirect_to root_path, notice: "You must be signed in to view your shelves."
    end 
  end
end
