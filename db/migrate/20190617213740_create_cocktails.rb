class CreateCocktails < ActiveRecord::Migration[5.0]

  def change 
    create_table :cocktails do |t|
      t.string :name
      t.string :alcoholic 
    end
  end

end
