class RecipesController < ApplicationController
  layout 'standard'
  before_action :authenticate_user!

  def index
    @user = current_user
    @recipes = @user.recipes
  end

  def show
    @user = current_user
    @recipe = Recipe.includes(:foods).find(params[:id])
  end

  def new
    @recipe = Recipe.new
    @foods = current_user.foods
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)
    redirect_to @recipe, notice: 'Recipe public status updated.'
  end

  def add_food
    @food = Food.new
  end

  def create_food
    @recipe = Recipe.find(params[:recipe_id])
    @food = @recipe.foods.new(food_params)
    @food.user = current_user

    if @recipe.save
      redirect_to @recipe
    else
      flash.now[:error] = @food.errors.full_messages
      render 'foods/new'
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      redirect_to recipes_path
    else
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.foods.destroy_all

    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :quantity, :price)
  end
end
