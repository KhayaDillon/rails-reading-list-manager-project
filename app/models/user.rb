class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :shelves
  has_many :shelved_books, through: :shelves
  has_many :books, through: :shelved_books
  has_one :current_book, class_name: 'Book'
  validates_associated :book, uniqueness: true

  after_create do |user|
    user.create_default_shelves
  end

  def create_default_shelves
    self.shelves.create(name: "Reading")
    self.shelves.create(name: "Finished Reading")
  end
end
