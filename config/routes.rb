Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :users, only: [:show]
  resources :foods

  resources :recipes, except: [:update] do
    resources :foods_recipes, only: [:new, :create, :destroy]
  end

  resources :public_recipes, except: [:update]

  resources :recipes do
    patch 'toggle_public', on: :member
  end
end
