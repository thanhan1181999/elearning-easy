class WordsController < ApplicationController
  def index
    @courseCategory=CourseCategory.all
    
    unless params[:sort].blank? && params[:type].blank? && params[:stateWord].blank?
      sort = params[:sort]
      type = params[:type]
      stateWord = params[:stateWord]
      @words_array = Word.filterOrder(sort)
      .filterType(type)
      .filterStateWord(stateWord,session[:user_id])
      @words = Kaminari.paginate_array(@words_array).page(params[:page]).per(10)
    else
      @words_array = Word.all.to_a
      @words = Kaminari.paginate_array(@words_array).page(params[:page]).per(10)
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

def importFromFile
  $size = File.readlines(params[:file]).size
  $i=0
  $words = []
  File.open(params[:file],"r") do |line|
      while $i<$size do
        content = line.gets || ""
        if (content.start_with?('@'))
          word={}
          word[:word]=content[1..content.length-2]
          line.gets
          meaning = line.gets
          word[:meaning]=meaning[2..meaning.length-2]
          word[:created_at] = Time.now
          word[:updated_at] = Time.now
          word[:course_category_id] = params[:course_category_id]
          $words << word
          $i+=3
          next
        end
        $i+=1
      end   
  end
  result = Word.insert_all($words)
  puts result
  flash[:success] = "Import word from file success !!"
  redirect_to words_path
end

  private
    def word_param
      params.require(:word).permit(:word, :picture, :meaning, :course_category_id)
    end

end
