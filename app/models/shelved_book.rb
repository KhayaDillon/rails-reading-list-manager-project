class ShelvedBook < ApplicationRecord
  belongs_to :shelf
  belongs_to :book
  validates :current_page, :status, presence: true

  def shelf_name
    self.shelf.name 
  end

  def page_count
    self.book.page_count
  end

  def set_shelf(user, name)
    self.shelf = user.shelves.find_by(name: name)
  end

  def title
    self.book.title
  end 

  #def current_location
  #  self.book.shelved_location || self.book.shelved_location = self
  #end 

  def pages_left
    self.page_count - self.current_page
  end
end
