class UsersController < ApplicationController

    def index
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

    private
    
    def logged_in?
        return head(:forbidden) unless session.include? :user_id
    end

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :password)
    end
    
end