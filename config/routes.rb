Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :users, only: [:show]

  resources :foods

  resources :recipes, except: [:update] do
    patch 'toggle_public', on: :member
  end

  resources :public_recipes, only: [:index]
end
