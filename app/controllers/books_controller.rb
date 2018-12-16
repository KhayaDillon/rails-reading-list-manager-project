class BooksController < ApplicationController
  def index
    if params[:search]
        resp = Faraday.get 'https://www.googleapis.com/books/v1/volumes' do |req|
          req.params['q'] = params[:search]
          req.params['key'] = ENV['API_KEY']
        end
        
        body_hash = JSON.parse(resp.body)
        @books = body_hash["items"]
    end
  end

  def recent_book
    @book = current_user.recent_book
  end
  
end
