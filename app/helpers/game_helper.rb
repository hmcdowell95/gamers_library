module GamesHelper

    def time_played(game)
        usergame = UserGame.find_by(user_id: @user.id, game_id: game.id)
        usergame.last_played
    end

end
