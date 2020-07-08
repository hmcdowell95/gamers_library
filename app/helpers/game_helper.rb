module GamesHelper

    def time_played(game)
        usergame = UserGame.find_by(user_id: @user.id, game_id: game.id)
        usergame.last_played
    end

    def set_users_game(game)
        usergame = UserGame.find_by(user_id: @user.id, game_id: game.id)
        usergame
    end
end
