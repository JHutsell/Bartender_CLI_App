class CreateFavorites < ActiveRecord::Migration[5.0]

  def change 
    create_table :favorites do |t|
      t.integer :cocktail_id 
      t.integer :customer_id
    end
  end

end
