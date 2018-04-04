class ShelvesController < ApplicationController
  def index
    @shelves = current_user.shelves
  end
end
