require 'rails_helper'

RSpec.feature 'recipes visit index', type: :feature do
  include Devise::Test::IntegrationHelpers
  before(:each) do
    @user = User.create(email: 'user@example.com', password: 'password', name: 'user')
    @recipe = Recipe.create(name: 'My recipe', preparation_time: 10, cooking_time: 10, description: 'test',
                            public: false, user: @user)
    @food = Food.create(name: 'My food', measurement_unit: 'test', price: 10, quantity: 10, user: @user)
    sign_in @user
    visit recipes_path
  end

  it 'shows the recipe name' do
    expect(page).to have_content(@recipe.name)
  end

  it 'shows the recipe description' do
    expect(page).to have_content(@recipe.description)
  end

  it 'shows and visits the link to the recipe show page' do
    expect(page).to have_link(@recipe.name)
    click_link @recipe.name
    expect(page).to have_current_path(recipe_path(@recipe))
  end
end

RSpec.feature 'recipes visit index and delete recipe', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(email: 'user@example.com', password: 'password', name: 'user')
    @recipe = Recipe.create(name: 'My recipe', preparation_time: 10, cooking_time: 10, description: 'test',
                            public: false, user: @user)
    @food = Food.create(name: 'My food', measurement_unit: 'test', price: 10, quantity: 10, user: @user)
    sign_in @user
    visit recipes_path
  end
  context 'when deleting a recipe' do
    it 'shows the button to delete the recipe' do
      expect(page).to have_button('Delete')
    end

    it 'deletes the recipe when the delete button is clicked' do
      click_button 'Delete'
      expect(page).to have_current_path(recipes_path)
      expect(page).to have_content('No recipes found')
      expect(page).not_to have_content(@recipe.name)
      expect(page).not_to have_content(@recipe.description)
      expect(page).not_to have_link(@recipe.name)
      expect(page).not_to have_button('Delete')
    end
  end
end

RSpec.feature 'recipes visit show recipe ', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(email: 'user@example.com', password: 'password', name: 'user')
    @recipe = Recipe.create(name: 'My recipe', preparation_time: 7, cooking_time: 10, description: 'test',
                            public: false, user: @user)
    @food = Food.create(name: 'My food', measurement_unit: 'test', price: 3, quantity: 4, user: @user)
    sign_in @user
    visit recipe_path(@recipe)
  end

  it 'shows the recipe details' do
    expect(page).to have_content(@recipe.name)
    expect(page).to have_content(@recipe.description)
    expect(page).to have_content(@recipe.preparation_time)
    expect(page).to have_content(@recipe.cooking_time)
  end

  it 'shows the button to generate shopping list and add ingredient' do
    expect(page).to have_button('General shopping list')
    expect(page).to have_button('Add Ingredient')
  end
end

RSpec.feature 'recipes visit show recipe and delete recipe food', type: :feature do
  include Devise::Test::IntegrationHelpers
  before(:each) do
    @user = User.create(email: 'user@example.com', password: 'password', name: 'user')
    @recipe = Recipe.create(name: 'My recipe', preparation_time: 7, cooking_time: 10, description: 'test',
                            public: false, user: @user)
    @food = Food.create(name: 'My food', measurement_unit: 'test', price: 3, quantity: 4, user: @user)
    sign_in @user
    visit recipe_path(@recipe)
  end
end

RSpec.feature 'recipes visit show recipe and test buttons redirections', type: :feature do
  include Devise::Test::IntegrationHelpers
  before(:each) do
    @user = User.create(email: 'user@example.com', password: 'password', name: 'user')
    @recipe = Recipe.create(name: 'My recipe', preparation_time: 7, cooking_time: 10, description: 'test',
                            public: false, user: @user)
    @food = Food.create(name: 'My food', measurement_unit: 'test', price: 3, quantity: 4, user: @user)
    sign_in @user
    visit recipe_path(@recipe)
  end

  it 'toggles the recipe to public' do
    expect(@recipe.public).to eq(false)
    expect(page).to have_button('Make Public')
    click_button 'Make Public'
    @recipe.reload
    expect(page).to have_button('Make Private')
    expect(@recipe.public).to eq(true)
  end
end
