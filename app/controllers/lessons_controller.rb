class LessonsController < ApplicationController
  def new
    @lesson = Course.find(params[:course_id]).lessons.build
  end
  def create
    @lesson = Course.find(params[:lesson][:course_id]).lessons.build(lesson_param)
    if @lesson.save
      flash[:seccess] = "added a lesson"
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
  end
  private
    def lesson_param
      params.require(:lesson).permit(:name,:picture,:course_id)
    end
end
