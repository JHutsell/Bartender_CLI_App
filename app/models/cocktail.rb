class Cocktail < ActiveRecord::Base 
    has_many :favorites
    has_many :customers, through: :favorites
end