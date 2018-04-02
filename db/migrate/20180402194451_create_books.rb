class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :genre
      t.integer :current_page
      t.integer :page_count
      t.string :status

      t.timestamps
    end
  end
end
