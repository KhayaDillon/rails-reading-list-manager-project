class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :genre
      t.integer :page_count
      t.string :cover
      t.string :preview

      t.timestamps
    end
  end
end
