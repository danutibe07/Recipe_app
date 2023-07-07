class FixFoodsRecipesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :foods_recipes
    create_table :foods_recipes do |t|
      t.belongs_to :recipe
      t.belongs_to :food
      t.integer :quantity
    end
  end
end
