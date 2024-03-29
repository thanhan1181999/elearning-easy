class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :show]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
  def index
    @users = User.paginate(page: params[:page],per_page: 8)
  end
  #get signup form
  def new
    @user = User.new
  end
  #post signup
  def create
    @user = User.new(user_params) # Not the final implementation!
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      # log_in @user
      # remember @user
      # flash[:success] = "Welcome to the Languafe easy!"
      # redirect_to @user
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end
  # get user/id
  def show
    @user = User.find(params[:id])
    if current_user.id == params[:id].to_i
      @courses = Course.where(user_id: current_user.following.ids).paginate(page: params[:page], per_page: 6)
      @users = User.where.not(id: current_user.id).limit(2) if @courses.blank?
    else
      @courses = @user.courses.paginate(page: params[:page], per_page: 6)
    end
    @studys = Study.where("user_id=?", params[:id])
    @joins = Join.where("user_id=?", params[:id])
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

  #show words remember
  def studiedWords
    @studys = Study.where(user_id: params[:id]).pluck(:word_id)
    @words = Word.where(id: @studys).paginate(page: params[:page],per_page: 10)
  end

  def joinedCourses
    @courses = Join.where("user_id=?", params[:id])
    .map do |join|
      Course.find_by(id: join.course.id)
    end
  end

  def createdCourses
    @courses = Course.where(user_id: params[:id])
    render 'users/joinedCourses'
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users =@user.following.paginate(page: params[:page])
    @studys = Study.where("user_id=?", params[:id])
    @joins = Join.where("user_id=?", params[:id])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    @studys = Study.where("user_id=?", params[:id])
    @joins = Join.where("user_id=?", params[:id])
    render 'show_follow'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :picture)
    end

end
