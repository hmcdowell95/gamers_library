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
            @game = Game.new(user_id: params[:user_id])
        end
    end

    def create
        @game = Game.new(game_params)
        if @game.save
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
        if params[:user_id].to.i == session[:user_id]
            user = User.find_by(id: params[:user_id])
            if user.nil?
              redirect_to users_path, alert: "User not found."
            else
              @game = user.games.find_by(id: params[:id])
              redirect_to user_games_path(user), alert: "Game not found." if @game.nil?
            end
        else
            set_game
        end
    end

    def update
        set_game
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

    private

    def game_params
        params.require(:game).permit(:name, :rating, :description, :user_id, :system_id)
    end

    def set_game
        @game = Game.find(params[:id])
    end

    def logged_in
        return head(:forbidden) unless session.include? :user_id
    end

end