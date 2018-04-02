class StaticController < ApplicationController
  def library
    @books = Books.all
  end
end
