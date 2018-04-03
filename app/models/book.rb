class Book < ApplicationRecord
  has_many :shelves
  validates :title, uniqueness: true
  validates :title, :author, :page_count, presence: true
end
