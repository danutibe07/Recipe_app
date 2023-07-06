Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :users, only: [:show]

  resources :foods

  resources :recipes, except: [:update] do
    get 'add_ingredient', to: 'recipes#add_ingredient'
    put 'create_ingredient', to: 'recipes#create_ingredient'
    delete 'remove_ingredient', to: 'recipes#remove_ingredient'
    patch 'toggle_public', on: :member
  end

  resources :public_recipes, only: [:index]
end
