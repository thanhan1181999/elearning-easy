module SessionsHelper
    def log_in(user)
        session[:user_id]=user.id
    end
    # Remembers a user in a persistent session.
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(:remember, cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    # Returns true if the given user is the current user.
    def current_user?(user)
        user == current_user
    end
    
    # by params
    def current_user_by_params?
        params[:id].to_i.eql? current_user.id
    end

    # not go to get login when loggined
    def redirect_to_user_path_if_logged_in
        redirect_to root_path if logged_in?
    end
    def logged_in?
        !current_user.nil?
    end
    def isAdmin?
        current_user.isAdmin?
    end
    # Forgets a persistent session.
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user=nil
    end
    # Redirects to stored location (or to the default).
    def redirect_back_or(default) 
        redirect_to(session[:forwarding_url] || default) 
        session.delete(:forwarding_url)
    end
    # Stores the URL trying to be accessed.
    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end


      # Confirms the correct user.
      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless @user == current_user
      end
      # Confirms the admin user.
      def admin_user
        if logged_in?
            unless current_user.isAdmin?
            flash[:danger] = "you need is admin"
            redirect_to users_path
            end
        else
            flash.now[:danger]="need login"
            redirect_to root_path
        end
      end
end
