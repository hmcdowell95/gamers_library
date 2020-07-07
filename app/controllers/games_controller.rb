class GamesController < ApplicationController
    before_action :logged_in

    def index
        if params[:user_id].to_i == session[:user_id]
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
    end

    def update
    end

    def destroy
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