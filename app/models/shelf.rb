class Shelf < ApplicationRecord
  belongs_to :user
  has_many :shelved_books
  has_many :books, through: :shelved_books
  validates :name, presence: true
end
