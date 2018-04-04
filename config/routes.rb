Rails.application.routes.draw do
  devise_for :users
  root to: "static#home"

  resources :users, only: [:show] do
    resources :shelves, only: [:index, :edit, :update]
  end 

  resources :shelves
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
