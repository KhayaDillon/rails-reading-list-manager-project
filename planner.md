Reading List Manager

  Actions
--Library pg lists all books
--User can create/add shelves (has a default 'Reading' and 'Completed' shelf)
--User can add a book to one of their shelves from Library
--User can can keep track of what page they're one
--User can change status of book 
-(currently reading, plan to read, on hold, finished, dropped) 
-dropped books are removed from shelf
-has one book currently reading


  Models
Books
--Title 
--Author
--Genre
--current page
--pg count
--has many shelves
--has a status

User
--username?
--email
--password
--has many shelves
--has many books through shelves
--has one book currently reading

Shelves
--name
--belongs to a user
--has many books

Shelved_books
-belong to shelves
-belongs to books

xx Status (Do I need this as a model?)
xx --label
xx --has many books

  Webpages
Homepage

All Books
-shows all books
-under each book is a dropbox of user's shelves to add it

User's Shelves
--route would be '/user/:id/shelf/:id'
--under each book is...
-an integer adjuster for the pg count
-amount of pages left (model method)
-drop box to adjust book status
-drop box to move to another shelf
-(submitting this info goes to book edit)

User Profile
--username?
--Count of books (model method)
--Count of total pages read (model method)
--currently reading & amount of pgs left
--completed books



