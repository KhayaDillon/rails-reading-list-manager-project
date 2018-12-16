class BooksController < ApplicationController
  def index
    if params[:search]
        resp = Faraday.get 'https://www.googleapis.com/books/v1/volumes' do |req|
          req.params['printType'] = "books"
          req.params['maxResults'] = "40"
          req.params['orderBy'] = "relevance"
          req.params['q'] = params[:search]
          req.params['key'] = ENV['API_KEY']
        end
        
        body_hash = JSON.parse(resp.body)
        @books = body_hash["items"].select do |book|
          volume = book["volumeInfo"]
          !!volume["authors"] && !!volume["pageCount"] && !!volume["imageLinks"]["thumbnail"] && !!volume["categories"]
        end
    end
  end

  def recent_book
    @book = current_user.recent_book
  end
  
end
