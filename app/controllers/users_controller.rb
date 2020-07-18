class UsersController < ApplicationController
    before_action :logged_in, only: [:index, :show, :edit, :update, :destroy]
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
        @users = User.all
    end

    def new 
        @user = User.new
    end

    def create
        if params[:user][:password] == params[:user][:password_confirmation] && params[:user][:password].strip != ""
            @user = User.new(user_params)
            if @user.save
                session[:user_id] = @user.id
                redirect_to user_path(@user)
            else
                render :new
            end
        else
            redirect_to new_user_path, alert: "passwords don't match"
        end
    end

    def show
    end

    def edit
       user_match
    end

    def update
        user_match
        if params[:user][:password] == params[:user][:password_confirmation] && params[:user][:password].strip != ""
            @user.update(user_params)
            if @user.save
                redirect_to user_path(@user)
            else
                render :edit
            end
        else
            redirect_to edit_user_path(@user), alert: "passwords don't match"
        end
    end

    def destroy
        user_match
        User.find(@user.id).destroy
        session.delete :user_id
        redirect_to new_user_path
    end

    def home
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :password)
    end

    def user_match
        redirect_to "/" unless @user.id == session[:user_id]
    end

end