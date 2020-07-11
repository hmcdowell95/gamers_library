module GamesHelper

    def time_played(game)
        user = User.find(session[:user_id])
        usergame = UserGame.find_by(user_id: user.id, game_id: game.id)
        if usergame
            usergame.last_played
        end
    end

    def set_users_game(game)
        user = User.find(session[:user_id])
        usergame = UserGame.find_by(user_id: user.id, game_id: game.id)
        usergame
    end
end
