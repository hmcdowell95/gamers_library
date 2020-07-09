class UsersController < ApplicationController
    before_action :logged_in?
    before_action :set_user
    skip_before_action :logged_in?, only: [:new, :create, :home]
    skip_before_action :set_user, only: [:index, :new, :create, :home]

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
        redirect_to new_user_path
    end

    def home
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

    def user_match
        return head(:forbidden) unless @user.id == session[:user_id]
    end

end