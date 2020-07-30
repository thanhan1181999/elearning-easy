class LessonsController < ApplicationController
  before_action :logged_in_user, only:[:flashcard, :test1]
  def new
    @lesson = Course.find(params[:course_id]).lessons.build
  end
  def create
    @lesson = Course.find(params[:lesson][:course_id]).lessons.build(lesson_param)
    if @lesson.save
      flash[:success] = "added a lesson"
      redirect_to course_path(params[:lesson][:course_id])
    else
      render 'new'
    end
  end
  def show
    @lesson = Lesson.find(params[:id])
    @words = @lesson.words
  end
  def flashcard
    @lesson = Lesson.find(params[:id])
    @words = @lesson.words
    if logged_in?
      @studies = Study.where(user_id:current_user.id, word_id: @words.ids).pluck(:word_id)
    end
  end
  def test1
    @lesson = Lesson.find(params[:id])
    @words = @lesson.words
  end
  def destroy
    @lesson = Lesson.find(params[:id])
    if @lesson.destroy
      respond_to do |format|
        # format.html {redirect_to course_path @lesson.course}
        format.js
      end
    end
  end

  private
    def lesson_param
      params.require(:lesson).permit(:name,:picture,:course_id)
    end
end
