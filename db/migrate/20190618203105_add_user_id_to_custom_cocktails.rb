class AddUserIdToCustomCocktails < ActiveRecord::Migration[5.0]
  
  def change
    add_column :custom_cocktails, :customer_id, :integer
  end
  
end
