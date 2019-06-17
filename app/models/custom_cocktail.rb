class CustomCocktail < ActiveRecord::Base 
    has_many :custom_ingredients 
    has_many :ingredients, through: :custom_ingredients
    belongs_to :customer
end