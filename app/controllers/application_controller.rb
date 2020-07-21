class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    include SessionsHelper

    def logged_in_user
        store_location #in session helper
        unless logged_in?
          flash[:danger] = "Please log in."
          redirect_to login_path
        end
    end
end
