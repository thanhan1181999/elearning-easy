class SessionsController < ApplicationController
  before_action :redirect_to_user_path_if_logged_in, only: [:new, :create]
  #get login
  def new
  end
  #post login
  def create
    debugger
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.actived?
        log_in(user)
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash[:danger]="invalid email/password"
      render 'new'
    end
  end
  def destroy
    log_out if logged_in?
    redirect_to login_path
  end
end
