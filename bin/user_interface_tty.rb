require 'bundler'
Bundler.require
system "clear"


def tty_home 
    #logo 
print "
  ______                                                                   __        __        __                     
  /      \\                                                                 /  |      /  |      /  |                    
 /$$$$$$  |  ______   _____  ____   _____  ____    ______   _______    ____$$ |      $$ |      $$/  _______    ______  
 $$ |  $$/  /      \\ /     \\/    \\ /     \\/    \\  /      \\ /       \\  /    $$ |      $$ |      /  |/       \\  /      \\ 
 $$ |      /$$$$$$  |$$$$$$ $$$$  |$$$$$$ $$$$  | $$$$$$  |$$$$$$$  |/$$$$$$$ |      $$ |      $$ |$$$$$$$  |/$$$$$$  |
 $$ |   __ $$ |  $$ |$$ | $$ | $$ |$$ | $$ | $$ | /    $$ |$$ |  $$ |$$ |  $$ |      $$ |      $$ |$$ |  $$ |$$    $$ |
 $$ \\__/  |$$ \\__$$ |$$ | $$ | $$ |$$ | $$ | $$ |/$$$$$$$ |$$ |  $$ |$$ \\__$$ |      $$ |_____ $$ |$$ |  $$ |$$$$$$$$/ 
 $$    $$/ $$    $$/ $$ | $$ | $$ |$$ | $$ | $$ |$$    $$ |$$ |  $$ |$$    $$ |      $$       |$$ |$$ |  $$ |$$       |
  $______   $$$$$$/  $$/  $$/  $__ $$/  $$/__$$/  $$$$$$$/ $__  __$/  $$$$$$$/       $$$$$$$$/ $$/ $$/   $$/  $$$$$$$/ 
  /      \\                     /  |       /  |             /  |/  |                                                    
 /$$$$$$  |  ______    _______ $$ |   __ _$$ |_    ______  $$/ $$ |  _______                                           
 $$ |  $$/  /      \\  /       |$$ |  /  / $$   |  /      \\ /  |$$ | /       |                                          
 $$ |      /$$$$$$  |/$$$$$$$/ $$ |_/$$/$$$$$$/   $$$$$$  |$$ |$$ |/$$$$$$$/                                           
 $$ |   __ $$ |  $$ |$$ |      $$   $$<   $$ | __ /    $$ |$$ |$$ |$$      \\                                           
 $$ \\__/  |$$ \\__$$ |$$ \\_____ $$$$$$  \\  $$ |/  /$$$$$$$ |$$ |$$ | $$$$$$  |                                          
 $$    $$/ $$    $$/ $$       |$$ | $$  | $$  $$/$$    $$ |$$ |$$ |/     $$/                                           
  $$$$$$/   $$$$$$/   $$$$$$$/ $$/   $$/   $$$$/  $$$$$$$/ $$/ $$/ $$$$$$$/                                            
                                                                                                                       
                                                                                                                       
  "                                                                                                                     
 
    
    TTY::Prompt.new.select("Welcome to Command Line Cocktails!") do |menu|
        menu.choice "Hi! I'm actually a VIP here 😎  (login)" => -> do tty_login end
        menu.choice "Hey there! I heard about this place from a friend 😌  (new user)" => -> do tty_create_user end
        menu.choice "Exit Bar" => -> do 
            #ASCII image
            exit
        end
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
    puts "
    (
        *                           )   *
                      )     *      (
            )        (                   (
           (          )     (             )
            )    *           )        )  (
           (                (        (      *
            )          H     )        )
                      [ ]            (
               (  *   |-|       *     )    (
         *      )     |_|        .          )
               (      | |    .  
         )           /   \\     .    ' .        *
        (           |_____|  '  .    .  
         )          | ___ |  \\~~~/  ' .   (
                *   | \\ / |   \\_/  \\~~~/   )
                    | _Y_ |    |    \\_/   (
        *     jgs   |-----|  __|__   |      *
                    `-----`        __|__ "
    $customer.reload
    TTY::Prompt.new.select("Would you like to...", active_color: :blue) do |menu|
        menu.choice "Try one of our famous cocktails? 🍸" => -> do tty_our_drinks end
        menu.choice "Create a custom drink of your own? 🤪" => -> do tty_create_drink end
        if !$customer.custom_cocktails.empty?
            menu.choice "Choose from a cocktail you've already created? 🤔" => -> do tty_custom_cocktails end
        end
        if !$customer.favorites.empty?
            menu.choice "Choose from your list of favorite cocktails? 😍" => -> do tty_favorites end
        end
        menu.choice "It's been so real. Buuuuuut my cat needs to be fed. Bye for now !" => -> do tty_home end
    end
    
end

#List of Premade options
def tty_our_drinks 
    TTY::Prompt.new.select("Would you like an alcoholic or non alcoholic cocktail?") do |menu|
        menu.choice "Alcoholic 😈" => -> do tty_alcoholic_drinks end
        menu.choice "Non-Alcoholic 😇" => -> do tty_boring_drinks end
    end
end

def tty_alcoholic_drinks 
    TTY::Prompt.new.select("Select one of these delicious options:", filter: true, active_color: :red) do |menu|
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
    TTY::Prompt.new.select("Select one of these delicious options:", filter: true, active_color: :red) do |menu|
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

#Favorites Functionality
def tty_favorite?
    TTY::Prompt.new.select("How did you like your drink?") do |menu|
        menu.choice "I loved it!!!😋  (Add to Favorites)" => -> do
            Favorite.create({customer_id: $customer.id, cocktail_id: $cocktail.id})
            tty_favorites
        end
        menu.choice "Eh, I wouldn't try it again honestly.🙃  (Don't add to Favorites)" => -> do 
            puts "Oh sorry about that 😖"
            tty_main_menu
        end
    end
end

def tty_favorites 
    TTY::Prompt.new.select("These are the drinks you've really liked so far:") do |menu|
        menu.choice "Can I see the menu please? (Main Menu)" => -> do tty_main_menu end
        $customer.favorites.each do |favorite|
            menu.choice "#{favorite.cocktail.name}" => -> do 
            $current_favorite = favorite
            tty_fav_options 
            end
        end
    end
end

def tty_fav_options 
    TTY::Prompt.new.select("#{$current_favorite.cocktail.name}") do |menu|
        menu.choice "Can I get one of these? 🥃  (Remain a favorite)" => -> do tty_main_menu end
        menu.choice "This is gross. How did it end up on my favorites list? 🤢  (Remove from Favorites)" => -> do 
            Favorite.delete($current_favorite.id)
            puts "Successfully deleted. Sorry about that. 😓"
            tty_main_menu
        end
    end
end

#Custom Cocktail Functionality
def tty_custom_cocktails 
    TTY::Prompt.new.select("These are the cocktails you've created:") do |menu|
        $customer.custom_cocktails.each do |custom_cocktail|
            menu.choice "#{custom_cocktail.name}" => -> do 
                $current_custom_cocktail = custom_cocktail
                tty_view_custom_cocktail
            end
        end
    end
end

def tty_create_drink
    $custom_cocktail_name = TTY::Prompt.new.ask("What would you like to name your drink?")
    $current_custom_cocktail = CustomCocktail.create({customer_id: $customer.id, name: $custom_cocktail_name})
    tty_add_to_custom_cocktail
end

def tty_add_to_custom_cocktail 
    TTY::Prompt.new.select("What would you like to add?",filter: true, active_color: :yellow) do |menu|
        menu.choice "That's all for now. 🤓" => -> do tty_view_custom_cocktail end
        Ingredient.all.each do |ingredient|
            menu.choice "#{ingredient.name}" => -> do 
                CustomIngredient.create({custom_cocktail_id: $current_custom_cocktail.id, ingredient_id: ingredient.id})
                tty_add_to_custom_cocktail
            end
        end
    end
end

def tty_view_custom_cocktail 
    $customer.reload
    $current_custom_cocktail.reload
    TTY::Prompt.new.select("#{$current_custom_cocktail.name}") do |menu|
        menu.choice "MMM that's tasty 😛" => -> do tty_main_menu end 
        menu.choice "I'd like to add to this actually 👅  (Add an ingredient)" => -> do tty_add_to_custom_cocktail end
        if !$current_custom_cocktail.ingredients.empty?
            menu.choice "Ooo something's not right 😟  (Delete an ingredient)" => -> do tty_remove_from_custom_cocktail end
        end
        if $customer.custom_cocktails
            menu.choice "Actually, this drink isn't very good. 👎  (Destroy)" => -> do 
                CustomCocktail.delete($current_custom_cocktail.id)
                tty_main_menu
            end
        end
    end
end

def tty_remove_from_custom_cocktail 
    TTY::Prompt.new.select("Which ingredient would you like to remove?") do |menu|
        $current_custom_cocktail.ingredients.each do |ingredient_i|
            menu.choice "#{ingredient_i.name}" => -> do 
                $bad_ingredient = CustomIngredient.find_by(ingredient_id: ingredient_i.id)
                CustomIngredient.delete($bad_ingredient.id)
                tty_view_custom_cocktail
            end
        end
    end

end

