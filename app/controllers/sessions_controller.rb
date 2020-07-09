class SessionsController < ApplicationController
    def new 
    end

    def create
        user = User.find_by(username: params[:user][:username])
        if user && user.authenticate(params[:user][:password])
          session[:user_id] = user.id
          redirect_to user_path(user)
        else
            redirect_to "/login"
        end
    end

    def fb_login
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
            u.username = auth['info']['name']
            u.password = auth['info']['email']
        end
        session[:user_id] = @user.id
        render 'users/home'
    end

    def destroy
        session.delete :user_id
        redirect_to "/"
    end

    private

    def auth
        request.env['omniauth.auth']
    end
end
