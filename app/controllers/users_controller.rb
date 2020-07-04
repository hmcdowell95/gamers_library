class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def new 
    end

    def create
        if params[:user][:password] == params[:user][:password_confirmation] 
            @user = User.new(user_params)
            if @user.valid?
                @user.save
                redirect_to user_path(@user)
            else
                redirect_to new_user_path, alert: "username has been taken already and/or password cannot be blank"
            end
        else
            redirect_to new_user_path, alert: "passwords don't match"
        end
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