Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :users, only: [:show]

  resources :foods

  resources :recipes, except: [:update] do
    get 'add_food', to: 'recipes#add_food'
    post 'create_food', to: 'recipes#create_food'
    patch 'toggle_public', on: :member
  end

  resources :public_recipes, only: [:index]
end
