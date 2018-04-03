class Book < ApplicationRecord
  has_many :shelves
  validates :title, uniqueness: true
  validates :title, :author, presence: true
end
