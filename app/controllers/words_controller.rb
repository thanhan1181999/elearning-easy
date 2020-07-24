class WordsController < ApplicationController
  before_action :logged_in_user, only: [:importFromFile]
  before_action :admin_user, only: [:importFromFile]
  before_action :logged_in_user, only: [:new, :create]
  
  def index
    @courseCategory=CourseCategory.all
    
    unless params[:sort].blank? && params[:type].blank? && params[:stateWord].blank?
      sort = params[:sort]
      type = params[:type]
      stateWord = params[:stateWord]
      @words_array = Word.filterOrder(sort)
      .filterType(type)
      .filterStateWord(stateWord,current_user.id)
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

          if content.include?(" /")
            word[:word]=content[1..content.index(" /")-1]
          else 
            word[:word]=content[1..content.length-2]
          end

          loop do
            meaning = line.gets
            $i+=1
            if meaning.starts_with?("-")
              word[:meaning]=meaning[1..meaning.length-2]
              break
            end
          end

          word[:created_at] = Time.now
          word[:updated_at] = Time.now
          word[:course_category_id] = params[:course_category_id]
          $words << word
          next
          
        end
        $i+=1
      end   
  end

  result = Word.insert_all($words)
  flash[:success] = "Import word from file success !!"
  redirect_to words_path
end

  private
    def word_param
      params.require(:word).permit(:word, :picture, :meaning, :course_category_id)
    end

end
