Rails.application.routes.draw do
  
  devise_for :users
  get 'homes/top'
  root to: "homes#top"
  get '/homes/about'=> "homes#about", as: "about"
  resources :books, only: [:new, :index, :show, :create]
  resources :users, only: [:show, :edit, :index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
