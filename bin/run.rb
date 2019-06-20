require_relative '../config/environment'
require_relative '../api/alcoholic_cocktail_api'

def sound(file_path)
    system "mpg123 #{file_path}"
end

sound("audio/T-Pain-buy_u_a_drank.mp3")
tty_home


binding.pry

0