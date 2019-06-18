class AlterCocktailTable < ActiveRecord::Migration[5.0]
  
  def change
    remove_column :cocktails, :alcoholic 
    add_column :cocktails, :alcoholic, :boolean
  end

end
