class SystemsController < ApplicationController
    before_action :logged_in?

    def index
        @systems = System.all
    end

    def show
        @system = System.find(params[:id])
    end

    def add_systems
        @user = current_user
        @user.update(system_params)
        redirect_to user_path(@user)
    end

    private
    
    def logged_in?
        return head(:forbidden) unless session.include? :user_id
    end

end