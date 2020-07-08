class GamesController < ApplicationController
    before_action :logged_in

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
        if params[:user_id].to_i == session[:user_id] && !User.exists?(params[:user_id])
            redirect_to users_path, alert: "User not found."
        else
            @game = Game.new
        end
    end

    def create
        @game = Game.new(game_params)
        if @game.valid?
            @game.creator = session[:user_id]
            @game.save
            users_game
            redirect_to game_path(@game)
        else
            render :new
        end
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
        game = Game.find(params[:id])
        return head(:forbidden) unless game.creator == session[:user_id]
        set_game
    end

    def update
        set_game
        return head(:forbidden) unless @game.creator == session[:user_id]
        @game.update(game_params)
        if @game.save
            redirect_to game_path(@game)
        else
            render :edit
        end
    end

    def destroy
        set_game
        @user = current_user
        @user.games.delete(@game.id)
        @user.save
        redirect_to user_games_path
    end

    def last_played
        @usersgame = UserGame.find_by(user_id: session[:user_id], game_id: params[:id])
        if @usersgame
            @usersgame.last_played = params[:input][:last_played]
            redirect_to user_games_path(session[:user_id])
        else
            redirect_to game_path(params[:id]), alert: "Have you played this game?"
        end
    end

    def add_game
        set_game
        users_game
        redirect_to user_games_path(@user)
    end

    private

    def game_params
        params.require(:game).permit(:name, :rating, :description, :system_id)
    end

    def set_game
        @game = Game.find(params[:id])
    end

    def logged_in
        return head(:forbidden) unless session.include? :user_id
    end

    def users_game
        @user = User.find(session[:user_id])
        @user.games << @game
        @user.save
    end
end