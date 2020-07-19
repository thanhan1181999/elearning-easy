class SessionsController < ApplicationController
  before_action :redirect_to_user_path_if_logged_in, only: [:new, :create]
  #get login
  def new
  end
  #post login
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash[:danger]="invalid email/password combination"
      render 'new'
    end
  end
  def destroy
    log_out if logged_in?
    redirect_to login_path
  end
end
