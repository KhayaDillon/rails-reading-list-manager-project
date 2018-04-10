Reading List Manager

  Actions
--Library pg lists all books
--User can create/add shelves (has a default 'Reading' and 'Completed' shelf)
--User can add a book to one of their shelves from Library
--User can keep track of what page they're on
--User can change status of book 
-(currently reading, plan to read, on hold, finished, dropped) 
-dropped books are removed from shelf
xx-has one book currently reading
-if current page equals total, completed (model method)


  Models
Books
--Title 
--Author
--Genre
--pg count
--has many shelves

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
--current page
--has a status

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
-amount of pages left (model method)
-an integer adjuster for the pg count
-drop box to adjust book status
-drop box to move to another shelf
-(submitting this info goes to book edit)
xx-(model method - page count must be less than page total)

User Profile
--username?
--Count of books (model method)
--Count of total pages read (model method)
--currently reading & amount of pgs left
--completed books



  Fixes
Sign up
-unique username

Shelves
-edit/delete shelves
-when I add a book, the current page isn't 0
-when I move book to another shelf, it appears twice in list (in reading shelf and examplee)
-when a book that's finished and you put it 'on hold' & 'reading' it doesn't move. but if the status changes to 'on hold' or 'reading' it moves to 'reading shelf' and the page left changes to 1
-if a book is finished, it can't be moved to another shelf (e.g. fantasy)
-adding book as 'finished' doesn't change the pages left or current page and the status is 'currently reading' but it's still in finished reading self
-a book that was 'finished' and the status changed to 'plan to reading' doesn't change current page to 0
-what to do in scenario status is plan to read and shelf is finished
- on hold should have a current page 
