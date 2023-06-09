Rails.application.routes.draw do
  
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end 
  get 'homes/top'
  root to: "homes#top"
  get "/home/about" => "homes#about", as: "about"
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :index, :update,]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
