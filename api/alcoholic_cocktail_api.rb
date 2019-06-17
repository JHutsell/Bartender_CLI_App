require 'net/http'
require 'open-uri'
require 'json'
require 'pry'

class GetAlcoholicCocktails
    # All Alcoholic Drinks
    URL = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic'


    def get_cocktails
        uri = URI.parse(URL)
        response = Net::HTTP.get_response(uri)
        response.body
    end

    def name_list
        alcoholic_cocktails = JSON.parse(self.get_cocktails)
        alcoholic_cocktail_list = alcoholic_cocktails["drinks"].map {|cocktail| cocktail["strDrink"] } 
    end


end



alcoholic_cocktails = GetAlcoholicCocktails.new

alcoholic_cocktail_array = alcoholic_cocktails.name_list