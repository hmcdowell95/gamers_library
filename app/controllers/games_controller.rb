class GamesController < ApplicationController


    def index
        if params[:user_id]
            @user = User.find_by(id: params[:user_id])
            if @user.nil?
              redirect_to users_path, alert: "User not found"
            else
              @games = @user.games
            end
        else
            @games = Game.all
        end
    end

    def new 
    end

    def create
    end

    def show
        if params[:user_id]
            @user = User.find_by(id: params[:user_id])
            @game = @user.games.find_by(id: params[:id])
            if @game.nil?
              redirect_to user_games_path(@user), alert: "Game not found"
            end
          else
            set_game
          end
    end

    def edit
    end

    def update
    end

    def destroy
    end

end