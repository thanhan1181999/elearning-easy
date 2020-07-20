class WordsController < ApplicationController
  def index
    @courseCategory=CourseCategory.all
    
    unless params[:sort].blank? && params[:type].blank? && params[:stateWord].blank?
      sort = params[:sort]
      type = params[:type]
      stateWord = params[:stateWord]
        @words = Word.order('word '+sort)
        .select do |word| 
          if type=="0" 
            true 
          else
            word.lessons[0].course.course_category.id.to_s==type 
          end
        end
        .select do |word|
          if stateWord=="0"
            true
          elsif stateWord=="1"
              has = Study.where(user_id: session[:user_id], word_id: word.id).count
              has == 1 #if remember
          elsif stateWord=="2"
              has = Study.where(user_id: session[:user_id], word_id: word.id).count
              has == 0
          end
        end
        .paginate(page: params[:page], per_page: 6)
    else
      @words = Word.paginate(page: params[:page], per_page: 6)
    end
  end

  def new
    @word = Word.new
  end
  def create
    @lesson = Lesson.find(params[:word][:lesson_id])
    @word = Word.new(word_param)
    if @lesson.words << @word
      flash[:seccess] = "added a word"
      redirect_to lesson_path(params[:word][:lesson_id])
    else
      render 'new'
    end
  end
  private
    def word_param
      params.require(:word).permit(:word, :picture, :meaning)
    end
end
