require_relative '../config/environment'
require_relative '../api/alcoholic_cocktail_api'

def sound(file_path)
    pid = fork{ exec 'mpg123','-q', file_path }
end

sound("audio/T-Pain-buy_u_a_drank.mp3")
tty_home
sound("audio/semisonic-closing_time.mp3")

binding.pry

0