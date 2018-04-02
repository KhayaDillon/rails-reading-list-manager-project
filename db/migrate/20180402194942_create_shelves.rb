class CreateShelves < ActiveRecord::Migration[5.1]
  def change
    create_table :shelves do |t|
      t.string :name
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
