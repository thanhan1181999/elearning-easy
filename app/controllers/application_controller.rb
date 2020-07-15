class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    def logged_in_user
        store_location
        unless logged_in?
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
    end

    include SessionsHelper
end
