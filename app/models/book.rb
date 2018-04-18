class Book < ApplicationRecord
  has_many :shelved_books
  has_many :shelves, through: :shelved_books
  has_one :shelved_location, class_name: "ShelvedBook", dependent: :destroy
  validates :title, :author, presence: true

  def pages_left
    self.page_count - self.shelved_location.current_page
  end
end
 