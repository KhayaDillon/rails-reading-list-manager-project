class CreateShelvedBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :shelved_books do |t|
      t.belongs_to :shelf, foreign_key: true
      t.belongs_to :book, foreign_key: true

      t.timestamps
    end
  end
end
