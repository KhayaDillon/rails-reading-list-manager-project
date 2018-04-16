class Book < ApplicationRecord
  has_many :shelved_books
  has_many :shelves, through: :shelved_books
  has_one :current_shelf, class_name: "ShelvedBook", dependent: :destroy
  validates :title, :author, presence: true

  def pages_left
    self.page_count - self.current_shelf.current_page
  end
end
