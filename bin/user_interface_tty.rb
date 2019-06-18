require 'bundler'
Bundler.require


def tty_home 
    #logo 
    TTY::Prompt.new.select("Welcome to Command Line Cocktails!") do |menu|
        menu.choice "Hi! I'm actually a VIP here 😎  (login)" => -> do tty_login end
        menu.choice "Hey there! I heard about this place from a friend 😌  (new user)" => -> do tty_create_user end
    end
end

def tty_create_user 
    $customer_name = TTY::Prompt.new.ask("What's your name buddy?")
    $customer = Customer.create(name: $customer_name)
    tty_main_menu
end

def tty_login 
    $customer_name = TTY::Prompt.new.ask("Oh welcome back, what was your name?")
    
    if Customer.find_by(name: $customer_name) == nil 
        puts "Sorry, couldn't find you on our list. We'll have to add you. "
        tty_create_user
    else
        $customer = Customer.find_by(name: $customer_name) 
        tty_main_menu
    end
end

def tty_main_menu 
    TTY::Prompt.new.select("Would you like to...") do |menu|
        menu.choice "Try one of our famous cocktails? 🍸" => -> do tty_our_drinks end
        menu.choice "Create a custom drink of your own? 🤪" => -> do tty_create_drink end
        if !$customer.custom_cocktails.empty?
            menu.choice "Choose from a cocktail you've already created? 🤔" => -> do tty_custom_cocktails end
        end
        if !$customer.favorites.empty?
            menu.choice "Choose from your list of favorite cocktails? 😍" => -> do tty_favorites end
        end
    end

end

def tty_our_drinks 
    TTY::Prompt.new.select("Would you like an alcoholic or non alcoholic cocktail?") do |menu|
        menu.choice "Alcoholic 😈" => -> do tty_alcoholic_drinks end
        menu.choice "Non-Alcoholic 😇" => -> do tty_boring_drinks end
    end
end

def tty_alcoholic_drinks 
    TTY::Prompt.new.select("Select one of these delicious options:") do |menu|
        Cocktail.all.each do |cocktail|
            if cocktail.alcoholic == true
                menu.choice "#{cocktail.name}" => -> do 
                    $cocktail = cocktail 
                    tty_favorite?
                end
            end
        end
    end
end

def tty_boring_drinks
    TTY::Prompt.new.select("Select one of these delicious options:") do |menu|
        Cocktail.all.each do |cocktail|
            if cocktail.alcoholic == false
                menu.choice "#{cocktail.name}" => -> do 
                    $cocktail = cocktail 
                    tty_favorite?
                end
            end
        end
    end
end

def tty_favorite?
    TTY::Prompt.new.select("How did you like your drink?") do |menu|
        menu.choice "I loved it!!!😋  (Add to Favorites)" => -> do
            Favorite.create({customer_id: $customer.id, cocktail_id: $cocktail.id})
            tty_customer_favorites
        end
        menu.choice "Eh, I wouldn't try it again honestly.🙃  (Don't add to Favorites)" => -> do 
            puts "Oh sorry about that 😖"
            tty_main_menu
        end
    end
end