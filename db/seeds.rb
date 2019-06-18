require_relative '../api/complete_cocktail_api'

Ingredient.destroy_all 
Cocktail.destroy_all 
CustomCocktail.destroy_all 
CustomIngredient.destroy_all 
Customer.destroy_all 
Favorite.destroy_all

ingredients = GetIngredients.new.name_list 
alcoholic_cocktails = GetAlcoholicCocktails.new.name_list 
non_alcoholic_cocktails = GetNonAlcoholicCocktails.new.name_list 

ingredients.each { |ingredient| Ingredient.create({name: ingredient}) }
alcoholic_cocktails.each { |alcoholic_cocktail| Cocktail.create({name: alcoholic_cocktail, alcoholic: true}) }
non_alcoholic_cocktails.each { |non_alcoholic_cocktail| Cocktail.create({name: non_alcoholic_cocktail, alcoholic: false}) } 



