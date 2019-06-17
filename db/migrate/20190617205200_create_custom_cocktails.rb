class CreateCustomCocktails < ActiveRecord::Migration[5.0]

  def change 
    create_table :custom_cocktails do |t| 
      t.string :name
    end
  end
  
end
