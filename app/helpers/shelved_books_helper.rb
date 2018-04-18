module ShelvedBooksHelper

  def shelf_name(shelved_book)
    shelved_book.shelf.name 
  end

  def page_count(shelved_book)
    shelved_book.book.page_count
  end
  
end