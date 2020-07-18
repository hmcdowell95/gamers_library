module ApplicationHelper

    def current_user
        User.find(session[:user_id])
    end

    def logged_in
        if !session.include? :user_id
            redirect_to new_user_path
        end
    end
end
