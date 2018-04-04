class Book < ApplicationRecord
  has_many :shelved_books
  has_many :shelves, through: :shelved_books
  validates :title, uniqueness: true
  validates :title, :author, presence: true
end
