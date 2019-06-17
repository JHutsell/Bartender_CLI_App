class CreateCustomIngredients < ActiveRecord::Migration[5.0]
  
  def change 
    create_table :custom_ingredients do |t| 
      t.integer :custom_cocktail_id
      t.integer :ingredient_id
    end
  end

end
