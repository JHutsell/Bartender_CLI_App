class Customer < ActiveRecord::Base 
    has_many :custom_cocktails
    has_many :favorites
    has_many :cocktails, through: :favorites

end