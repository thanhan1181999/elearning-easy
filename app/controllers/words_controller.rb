class WordsController < ApplicationController
  def index
    @words =Word.all.paginate(page: params[:page], per_page: 6)
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
