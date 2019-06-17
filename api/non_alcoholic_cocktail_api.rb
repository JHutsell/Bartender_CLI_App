require 'net/http'
require 'open-uri'
require 'json'
require 'pry'

class GetNonAlcoholicCocktails
    # All Alcoholic Drinks
    URL = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic'


    def get_cocktails
        uri = URI.parse(URL)
        response = Net::HTTP.get_response(uri)
        response.body
    end

    def name_list
        non_alcoholic_cocktails = JSON.parse(self.get_cocktails)
        non_alcoholic_cocktail_list = non_alcoholic_cocktails["drinks"].map {|cocktail| cocktail["strDrink"] } 
    end


end



non_alcoholic_cocktails = GetNonAlcoholicCocktails.new

non_alcoholic_cocktail_array = non_alcoholic_cocktails.name_list
