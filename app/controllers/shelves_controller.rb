class ShelvesController < ApplicationController
  def index
    @shelves = current.user.shelves
  end
end
