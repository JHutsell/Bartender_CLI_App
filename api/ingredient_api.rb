require 'net/http'
require 'open-uri'
require 'json'
require 'pry'

class GetIngredients

    URL = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

    def get_ingredients
        uri = URI.parse(URL)
        response = Net::HTTP.get_response(uri)
        response.body
    end

    def name_list
        ingredients = JSON.parse(self.get_ingredients)
        ingredients["drinks"].map {|ingredient| ingredient["strIngredient1"] } 
    end


end



ingredients = GetIngredients.new

ingredients_array = ingredients.name_list

