class JoinsController < ApplicationController
  def create
    @join = Join.find_by user_id: params[:join][:user_id], course_id: params[:join][:course_id] 
    @join ||= Join.new(join_params)
    @course = Course.find(params[:join][:course_id])
    if @join.save  
      @user = User.find_by(id: params[:join][:user_id])
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @join = Join.find_by user_id: params[:join][:user_id], course_id: params[:join][:course_id] 
    @course = Course.find(params[:join][:course_id])
    unless @join.blank?
      @join.destroy 
      @user = User.find_by(id: params[:join][:user_id])
      respond_to do |format|
        format.js
      end
    end
  end

  private
    def join_params
      params.require(:join).permit(:user_id, :course_id)
    end
end
