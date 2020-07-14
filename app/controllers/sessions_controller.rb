class SessionsController < ApplicationController
  #get login
  def new
  end
  #post login
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to root_path
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
