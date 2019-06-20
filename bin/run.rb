require_relative '../config/environment'
require_relative '../api/alcoholic_cocktail_api'

def sound(file_path)
    pid = fork{ exec 'mpg123','-q', file_path }
end

# Play buy u a drank
sound("audio/T-Pain-buy_u_a_drank.mp3")

# start bartending app
tty_home
