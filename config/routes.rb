Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root to: "static#home"

  get "users/:id/recent_book", to: "books#recent_book"

  resources :users, only: [:show] do
    resources :shelves, only: [:index, :new]
  end 

  resources :shelved_books, only: [:create, :update]

  resources :shelves
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
