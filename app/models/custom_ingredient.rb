class CustomIngredient < ActiveRecord::Base 
    belongs_to :ingredient 
    belongs_to :custom_cocktail
end