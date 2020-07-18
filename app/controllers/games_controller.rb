class GamesController < ApplicationController
    include GamesHelper
    include ApplicationHelper
    before_action :logged_in

    def index
        if params[:user_id]
            @user = User.find_by(id: params[:user_id])
            if @user.nil?
              redirect_to users_path, alert: "User not found"
            else
              @games = @user.games
            end
        elsif params[:query]
            @games = Game.search(params[:query])
        else
            @games = Game.all
        end
    end

    def new 
        @game = Game.new
    end

    def create
        # refactor for build or create/find?
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
        set_game
        redirect_to game_path(@game) unless @game.creator == session[:user_id]
    end

    def update
        set_game
        return head(:forbidden) unless @game.creator == session[:user_id]
        if @game.update(game_params)
            redirect_to game_path(@game)
        else
            render :edit
        end
    end

    def destroy
        set_game
        set_users_game(@game).destroy
        redirect_to user_games_path(session[:user_id])
    end

    def last_played
        @usersgame = UserGame.find_by(user_id: session[:user_id], game_id: params[:id])
        if @usersgame
            @usersgame.last_played = params[:input][:last_played]
            @usersgame.save
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

    def users_game
        @user = current_user
        @user.games << @game
        @user.save
    end
end