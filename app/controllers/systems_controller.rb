class SystemsController < ApplicationController
    before_action :logged_in?

    def index
    end

    def show
        @system = System.find(params[:id])
    end

    def add_systems
        @user = User.find(session[:user_id])
        @user.update(system_params)
        redirect_to user_path(@user)
    end

    private
    
    def logged_in?
        return head(:forbidden) unless session.include? :user_id
    end

    def system_params
        params.require(:system).permit(system_ids:[])
    end

end