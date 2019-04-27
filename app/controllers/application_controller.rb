class ApplicationController < ActionController::Base

    helper_method :current_user, :loggedin?
    
    def login!(user)
        @current_user = user
        session[:session_token] = current_user.reset_session_token!
    end

    def logout
        session[:session_token] = nil
        current_user.reset_session_token!
        @current_user = nil
    end

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
        return @current_user
    end

    def loggedin?
        !!current_user
    end

    def require_login
        if !loggedin?
            redirect_to new_session_url
        end
    end

    
end
