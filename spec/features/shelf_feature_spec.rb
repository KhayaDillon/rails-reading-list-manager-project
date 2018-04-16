describe 'Feature Test: Shelf', :type => :feature do

  describe "Add Book to Shelf" do

    context "logged in" do
      before(:each) do
        @user = User.last
        login_as(@user, scope: :user)
      end

      it "Adds a book to a user's shelf" do
        first_book = Book.first
        shelf = @user.shelves.sample
        visit books_path
        within("form[action='#{shelved_books_path(book_id: first_item, shelf_id: shelf.id)}']") do
          click_button("Add Book to Shelf")
        end
        expect(shelf.books).to include(first_book)
      end

      it "Gives the book a default status of Plan to Read" do
        reading_shelf = @user.shelves.find_by(name: "Reading")
        first_book = Book.first
        ShelvedBook.create(book: first_book, shelf: reading_shelf)
        visit user_shelves_path(@user)
        expect(page).to have_select('#shelved_book_status', selected: 'Plan to Read')
      end

    end
  end
end