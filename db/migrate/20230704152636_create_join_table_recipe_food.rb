class CreateJoinTableRecipeFood < ActiveRecord::Migration[7.0]
  def change
    create_join_table :recipes, :foods do |t|
      t.integer :quantity
      t.references :recipes, foreign_key: true
      t.references :foods, foreign_key: true
    end
  end
end
