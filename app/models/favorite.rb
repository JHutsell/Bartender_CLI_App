class Favorite < ActiveRecord::Base 
    belongs_to :customer
    belongs_to :cocktail
end