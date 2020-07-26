class RelationshipsController < ApplicationController
  before_action :logged_in_user
  
  def create
    # if here not is profile of current user
    # @user is followed  
    @user = User.find(params[:followed_id])
    unless current_user?(@user)
      @current_user.follow(@user)
    end
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    unless current_user?(@user)
      @current_user.unfollow(@user)
    end
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

end
