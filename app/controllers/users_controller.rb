class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show]
  before_action :correct_user, only: [:edit, :update, :show]

  def index
    @users = User.paginate(page: params[:page])
  end
  #get signup form
  def new
    @user = User.new
  end
  #post signup
  def create
    @user = User.new(user_params) # Not the final implementation!
    if @user.save
      log_in @user
      remember @user
      flash[:success] = "Welcome to the Languafe easy!"
      redirect_to @user
    else
      render 'new'
    end
  end
  # get user/id
  def show
    @user = User.find(params[:id])
    @courses = @user.courses.paginate(page: params[:page], per_page: 6)
    @study = Study.where("user_id=?", params[:id])
  end
  # get form to update
  def edit
    @user = User.find(params[:id])
  end
  #patch to update
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  # delete user
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:danger]="You are not allowed to access"
        redirect_to(root_url) 
      end
    end
    # Confirms the admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def logged_in_user
      store_location
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_path
      end
  end
end
