# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
      --Installed rails gem, then generated rails application
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes) 
      --A User has many Shelves
- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)
      --A Shelf belongs to a User
- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients)
      --A Shelf has many Books through ShelvedBooks
      --A Book has many Shelves through ShelvedBooks
      --A User has many Books through ShelvedBooks
- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)
      --ShelvedBook join table has a current_page and a status, which the user adjusts
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
      --All models have validations requiring essential attributes to be present
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
      --User model #pages_read shows the total number of pages they have read by adding all the user's book's current pages. 
      --Book model #pages_left shows number of pages left by subtracting the current page from a book's page count.
- [x] Include signup (how e.g. Devise)
- [x] Include login (how e.g. Devise)
- [x] Include logout (how e.g. Devise)
      --Used devise by adding gem, installing it, then generating devise User. Added 'name' attribute by adding it to migration, generating views, and then customizing the forms.  
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
      --Used Devise and Google omniauth with devise
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
      --To view their shelves, users go to users/id/shelves
- [o] Include nested resource "new" form (URL e.g. recipes/1/ingredients)
      --Forms are on same page as the user's shelves, there isn't a seperate page for them, so unable to do 'users/id/shelves/new' or 'users/id/shelved_books/new'
- [x] Include form display of validation errors (form URL e.g. /recipes/new)
      --In shelf form the name must be present. Also can not be the same as the default shelf names, if so a css styled div with class name 'field_with_errors' displays the issue. The same div displays with any shelved_book create/update issues. 

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate