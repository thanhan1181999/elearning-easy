class UsersController < ApplicationController
  def new
    @user = User.new
  end
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
  def show
    @user = User.find(params[:id])
    @courses = @user.courses.paginate(page: params[:page], per_page: 6)
  end
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
