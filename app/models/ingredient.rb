class Ingredient < ActiveRecord::Base
    has_many :custom_ingredients
    has_many :custom_cocktails, through: :custom_ingredients
end