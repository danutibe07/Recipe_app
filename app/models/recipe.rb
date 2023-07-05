class Recipe < ApplicationRecord
    belongs_to :user, class_name: 'User', foreign_key: 'user_id'
    has_many :foods_recipes, class_name: 'RecipeFood', foreign_key: 'recipe_id'
    has_many :foods, through: :foods_recipes
  
    accepts_nested_attributes_for :foods_recipes
  
    validates :name, presence: true
    validates :preparation_time, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :cooking_time, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :description, presence: true
  end
  