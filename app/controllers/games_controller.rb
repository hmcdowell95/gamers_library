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
    end

    def edit
    end

    def update
    end

    def destroy
    end

end