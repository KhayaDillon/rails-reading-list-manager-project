class ShelvedBook < ApplicationRecord
  belongs_to :shelf
  belongs_to :book

  def shelf_name
    self.shelf.name 
  end

  def page_count
    self.book.page_count
  end

  def set_shelf(user, name)
    self.shelf = user.shelves.find_by(name: name)
  end
end
