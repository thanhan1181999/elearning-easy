class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update] 

  #get form nhap gmail when forget password
  def new
  end

  #nhap email, create reset_token luu vao db, va gui mail chua link reset
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions" 
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[ :user][ :password].empty? 
        @user.errors.add(:password, "can't be empty") 
        render 'edit'
    elsif 
      @user.update_attributes(user_params) 
      flash[:success] = "Password has been reset. login to start"
      redirect_to login_path
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require( :user).permit( :password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # Confirms a valid user.
    def valid_user
      unless ( @user && @user.activated? && @user.authenticated?( :reset, params[ :id]))
        redirect_to root_url
      end
    end  

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired." 
        redirect_to new_password_reset_url
      end
    end

end
